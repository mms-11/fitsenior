# Resolver Erro "invalid_credentials"

## Problema
Você está recebendo o erro `{"code": 400, "error_code":"invalid_credentials",...}` ao tentar fazer login.

## Causa
Isso geralmente acontece quando:
1. O usuário `dev@fitsenior.com` já existe no Supabase mas com uma senha diferente
2. O usuário foi criado mas precisa confirmar o email
3. Há algum problema com as credenciais armazenadas

## Solução Rápida

### Passo 1: Deletar o usuário existente
1. Acesse: https://app.supabase.com
2. Selecione seu projeto
3. Vá em **Authentication** > **Users**
4. Procure por `dev@fitsenior.com`
5. Clique nos três pontos (...) ao lado do usuário
6. Selecione **Delete** ou **Deletar**
7. Confirme a exclusão

### Passo 2: Desabilitar confirmação de email (IMPORTANTE)
1. No mesmo projeto, vá em **Authentication** > **Settings**
2. Procure por **"Enable email confirmations"** ou **"Confirmar email"**
3. **Desmarque** essa opção
4. Clique em **Save** ou **Salvar**

### Passo 3: Limpar dados do app
1. Feche completamente o app no simulador/dispositivo
2. Se estiver usando simulador: **Device** > **Erase All Content and Settings**
3. Ou delete o app e reinstale

### Passo 4: Executar o app novamente
1. Execute o app
2. O app tentará fazer login automaticamente
3. Se o usuário não existir, ele será criado automaticamente
4. O login deve funcionar agora!

## Verificação

Após seguir os passos acima:
- ✅ O app deve fazer login automaticamente
- ✅ Não deve aparecer erro de "invalid_credentials"
- ✅ Você deve ver a tela principal do app

## Logs para Debug

Se ainda não funcionar, verifique os logs no console do Xcode:
- Procure por: "Tentando fazer login com usuário padrão..."
- Procure por: "Credenciais inválidas detectadas"
- Procure por: "Criando usuário padrão..."
- Procure por: "Login automático bem-sucedido!"

## Se o Problema Persistir

1. Verifique se a URL e API Key do Supabase estão corretas em `SupabaseClient.swift`
2. Verifique se há conexão com a internet
3. Verifique os logs do console para mensagens de erro mais detalhadas
4. Tente criar o usuário manualmente no Supabase Dashboard primeiro

