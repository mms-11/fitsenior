# 🔐 Como Fazer Login no App FitSenior

## ✅ Usuário Padrão Configurado

O app agora tem um **usuário padrão** que é criado automaticamente:

**Email:** `dev@fitsenior.com`  
**Senha:** `123456`

## 🚀 Como Funciona

1. **Primeira vez que abre o app:**
   - O app tenta fazer login com `dev@fitsenior.com` / `123456`
   - Se o usuário não existir, ele é criado automaticamente
   - Você é logado automaticamente

2. **Após sair do app:**
   - Quando você faz logout, pode fazer login novamente usando:
     - **Email:** `dev@fitsenior.com`
     - **Senha:** `123456`

## 🚪 Como Fazer Login Manual

Quando você sair do perfil (fazer logout), você pode fazer login de duas formas:

### Opção 1: Usar o Usuário Padrão (Recomendado)

1. **No app iOS:**
   - Abra a tela de login
   - Digite:
     - **Email:** `dev@fitsenior.com`
     - **Senha:** `123456`
   - Clique em **"Entrar"**

### Opção 2: Criar uma Nova Conta

1. **No app iOS:**
   - Abra a tela de login
   - Clique na aba **"Cadastro"**
   - Digite:
     - **Email:** qualquer email válido (ex: `teste@fitsenior.com`)
     - **Senha:** qualquer senha com pelo menos 6 caracteres (ex: `123456`)
   - Clique em **"Cadastrar"**

2. **Após o cadastro:**
   - Você será automaticamente logado
   - Pode usar essas credenciais para fazer login depois

## ⚙️ Modo de Desenvolvimento vs. Modo Real

### Modo de Desenvolvimento (Atual)
```swift
private let developmentMode = true
```
- **Vantagem:** Não precisa fazer login, entra automaticamente
- **Desvantagem:** Não testa autenticação real

### Modo Real (Para Produção)
```swift
private let developmentMode = false
```
- **Vantagem:** Testa autenticação real com Supabase
- **Desvantagem:** Precisa fazer login toda vez

## 🔧 Como Desativar o Modo de Desenvolvimento

Se quiser testar o login real:

1. **Abra:** `FitSenior/Services/AuthService.swift`
2. **Altere a linha 13:**
   ```swift
   private let developmentMode = false // Mude para false
   ```
3. **Compile e execute** o app novamente
4. Agora você precisará fazer login real

## 🎯 Resumo Rápido

**Usuário Padrão Configurado:**
- ✅ Email: `dev@fitsenior.com`
- ✅ Senha: `123456`
- ✅ Criado automaticamente na primeira vez
- ✅ Login automático ao abrir o app

**Após Sair do Perfil:**
- 🔑 Use as credenciais padrão: `dev@fitsenior.com` / `123456`
- 📝 Ou crie uma nova conta no app

**Modo de Desenvolvimento:**
- ⚙️ Atualmente desativado (`developmentMode = false`)
- ⚙️ Para ativar modo dev (sem Supabase), mude para `true` no `AuthService.swift`

## ⚠️ Importante

- O email `dev@fitsenior.com` no modo desenvolvimento **não é uma conta real** no Supabase
- É apenas um usuário fictício criado localmente
- Para usar autenticação real, você precisa criar uma conta real no Supabase

