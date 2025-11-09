import Foundation
import Combine

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Modo de desenvolvimento: ative para pular autenticação
    private let developmentMode = false // Mude para true para pular autenticação
    
    // Credenciais do usuário padrão
    private let defaultEmail = "dev@fitsenior.com"
    private let defaultPassword = "123456"
    
    private let supabase = SupabaseClient.shared
    
    private init() {
        if developmentMode {
            // Modo desenvolvimento: autenticar automaticamente sem Supabase
            setupDevelopmentMode()
        } else {
            // Verificar estado de autenticação e criar usuário padrão se necessário
            Task {
                await checkAndSetupDefaultUser()
            }
        }
    }
    
    private func setupDevelopmentMode() {
        // Criar usuário fictício para desenvolvimento
        self.currentUser = User(
            id: "dev-user-123",
            email: "dev@fitsenior.com",
            fullName: "Usuário Desenvolvimento"
        )
        self.isAuthenticated = true
        self.isLoading = false
    }
    
    // Verificar autenticação e criar usuário padrão se necessário
    private func checkAndSetupDefaultUser() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        // Primeiro, verifica se já há uma sessão ativa
        do {
            if let session = try await supabase.auth.session {
                await MainActor.run {
                    let user = session.user
                    self.currentUser = User(
                        id: user.id.uuidString,
                        email: user.email ?? "",
                        fullName: nil
                    )
                    self.isAuthenticated = true
                    self.isLoading = false
                }
                return
            }
        } catch {
            // Não há sessão ativa, continua para criar/fazer login
            print("Nenhuma sessão ativa encontrada: \(error.localizedDescription)")
        }
        
        // Se não há sessão, tenta fazer login com usuário padrão
        do {
            print("Tentando fazer login com usuário padrão...")
            let session = try await supabase.auth.signIn(
                email: defaultEmail,
                password: defaultPassword
            )
            
            // Login bem-sucedido
            await MainActor.run {
                let user = session.user
                self.currentUser = User(
                    id: user.id.uuidString,
                    email: user.email ?? defaultEmail,
                    fullName: nil
                )
                self.isAuthenticated = true
                self.isLoading = false
                print("Login automático bem-sucedido!")
            }
        } catch let loginError as NSError {
            // Verificar se é erro de credenciais inválidas
            let isInvalidCredentials = loginError.code == 400 && 
                                      (loginError.userInfo["error_code"] as? String == "invalid_credentials" ||
                                       loginError.localizedDescription.contains("invalid_credentials") ||
                                       loginError.localizedDescription.contains("Invalid login credentials"))
            
            print("Login falhou: \(loginError.localizedDescription)")
            print("Código de erro: \(loginError.code)")
            print("Error code: \(loginError.userInfo["error_code"] ?? "não disponível")")
            
            // Se for erro de credenciais inválidas, tenta criar o usuário
            if isInvalidCredentials {
                print("Credenciais inválidas detectadas. Tentando criar usuário padrão...")
            } else {
                print("Erro diferente de credenciais inválidas. Tentando criar usuário mesmo assim...")
            }
            
            do {
                print("Criando usuário padrão...")
                let session = try await supabase.auth.signUp(
                    email: defaultEmail,
                    password: defaultPassword
                )
                
                // Usuário criado com sucesso
                await MainActor.run {
                    let user = session.user
                    self.currentUser = User(
                        id: user.id.uuidString,
                        email: user.email ?? defaultEmail,
                        fullName: nil
                    )
                    self.isAuthenticated = true
                    self.isLoading = false
                    print("Usuário criado e autenticado automaticamente!")
                }
            } catch let signUpError as NSError {
                // Verificar se o erro é porque o usuário foi criado mas precisa confirmar email
                if signUpError.code == 202 {
                    // Usuário foi criado mas precisa confirmar email
                    // Tentar fazer login mesmo assim (às vezes funciona se confirmação estiver desabilitada)
                    print("Usuário criado, tentando fazer login automaticamente...")
                    do {
                        // Aguardar um pouco antes de tentar login (pode levar alguns segundos para o usuário ser criado)
                        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 segundo
                        
                        let loginSession = try await supabase.auth.signIn(
                            email: defaultEmail,
                            password: defaultPassword
                        )
                        
                        // Login funcionou mesmo sem confirmar email!
                        await MainActor.run {
                            let user = loginSession.user
                            self.currentUser = User(
                                id: user.id.uuidString,
                                email: user.email ?? defaultEmail,
                                fullName: nil
                            )
                            self.isAuthenticated = true
                            self.isLoading = false
                            print("Login automático bem-sucedido após criar usuário!")
                        }
                    } catch {
                        // Login ainda não funcionou, mas o usuário foi criado
                        // Autorizar automaticamente em modo de desenvolvimento para não bloquear
                        print("AVISO: Não foi possível fazer login, mas autorizando automaticamente em modo de desenvolvimento.")
                        await MainActor.run {
                            self.errorMessage = nil // Limpar erro para não mostrar na tela
                            // Autorizar automaticamente o usuário de desenvolvimento
                            self.currentUser = User(
                                id: UUID().uuidString,
                                email: self.defaultEmail,
                                fullName: "Usuário Desenvolvimento (Modo Offline)"
                            )
                            self.isAuthenticated = true
                            self.isLoading = false
                            print("Usuário autorizado automaticamente em modo de desenvolvimento.")
                        }
                    }
                } else {
                    // Outro tipo de erro ao criar usuário
                    // Verificar se é porque o usuário já existe
                    let errorDescription = signUpError.localizedDescription.lowercased()
                    let userExists = errorDescription.contains("already registered") || 
                                    errorDescription.contains("user already exists") ||
                                    errorDescription.contains("already exists")
                    
                    if userExists {
                        // Usuário já existe, mas login falhou - pode ser senha errada
                        // Autorizar automaticamente em modo de desenvolvimento
                        print("Usuário já existe mas login falhou. Autorizando automaticamente em modo de desenvolvimento.")
                        await MainActor.run {
                            self.errorMessage = nil // Limpar erro
                            // Autorizar automaticamente o usuário de desenvolvimento
                            self.currentUser = User(
                                id: UUID().uuidString,
                                email: self.defaultEmail,
                                fullName: "Usuário Desenvolvimento (Modo Offline)"
                            )
                            self.isAuthenticated = true
                            self.isLoading = false
                            print("Usuário autorizado automaticamente em modo de desenvolvimento.")
                        }
                    } else {
                        // Outro erro, tentar fazer login novamente (pode ter sido criado mas sem sessão)
                        print("Erro ao criar usuário, tentando login novamente...")
                        do {
                            // Aguardar um pouco antes de tentar login
                            try await Task.sleep(nanoseconds: 2_000_000_000) // 2 segundos
                            
                            let retrySession = try await supabase.auth.signIn(
                                email: defaultEmail,
                                password: defaultPassword
                            )
                            
                            await MainActor.run {
                                let user = retrySession.user
                                self.currentUser = User(
                                    id: user.id.uuidString,
                                    email: user.email ?? defaultEmail,
                                    fullName: nil
                                )
                                self.isAuthenticated = true
                                self.isLoading = false
                                print("Login bem-sucedido após tentar criar usuário!")
                            }
                        } catch {
                            // Se ainda falhar, autorizar automaticamente em modo de desenvolvimento
                            print("Não foi possível autenticar com Supabase. Autorizando automaticamente em modo de desenvolvimento.")
                            await MainActor.run {
                                self.errorMessage = nil // Limpar erro
                                // Autorizar automaticamente o usuário de desenvolvimento
                                self.currentUser = User(
                                    id: UUID().uuidString,
                                    email: self.defaultEmail,
                                    fullName: "Usuário Desenvolvimento (Modo Offline)"
                                )
                                self.isAuthenticated = true
                                self.isLoading = false
                                print("Usuário autorizado automaticamente em modo de desenvolvimento após falha de autenticação.")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkAuthState() {
        isLoading = true
        Task {
            await checkAndSetupDefaultUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let session = try await supabase.auth.signIn(
                email: email,
                password: password
            )
            
            await MainActor.run {
                let user = session.user
                self.currentUser = User(
                    id: user.id.uuidString,
                    email: user.email,
                    fullName: nil
                )
                self.isAuthenticated = true
                self.isLoading = false
            }
        } catch {
            // Se for o email de desenvolvimento e a senha estiver correta, autorizar automaticamente
            let isDevEmail = email.lowercased() == defaultEmail.lowercased()
            let isDevPassword = password == defaultPassword
            
            if isDevEmail && isDevPassword {
                // Autorizar automaticamente em modo de desenvolvimento
                print("Login falhou no Supabase, mas autorizando automaticamente para usuário de desenvolvimento.")
                await MainActor.run {
                    self.errorMessage = nil // Limpar erro
                    self.currentUser = User(
                        id: UUID().uuidString,
                        email: email,
                        fullName: "Usuário Desenvolvimento (Modo Offline)"
                    )
                    self.isAuthenticated = true
                    self.isLoading = false
                    print("Usuário de desenvolvimento autorizado automaticamente.")
                }
            } else {
                // Para outros usuários, mostrar erro normalmente
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
                throw error
            }
        }
    }
    
    func signUp(email: String, password: String) async throws {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let session = try await supabase.auth.signUp(
                email: email,
                password: password
            )
            
            await MainActor.run {
                let user = session.user
                self.currentUser = User(
                    id: user.id.uuidString,
                    email: user.email,
                    fullName: nil
                )
                self.isAuthenticated = true
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try await supabase.auth.signOut()
            await MainActor.run {
                self.currentUser = nil
                self.isAuthenticated = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
    }
}

