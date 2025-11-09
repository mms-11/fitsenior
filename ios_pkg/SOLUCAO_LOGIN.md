# Solução para Problemas de Login

## Problema
O login automático e manual não está funcionando com as credenciais `dev@fitsenior.com` / `123456`.

## Possíveis Causas

### 1. Confirmação de Email Ativada no Supabase
O Supabase pode estar configurado para exigir confirmação de email antes de permitir login. Isso significa que quando você cria um usuário, ele não recebe uma sessão imediatamente.

**Solução: Desabilitar confirmação de email (recomendado para desenvolvimento)**

1. Acesse o [Dashboard do Supabase](https://app.supabase.com)
2. Selecione seu projeto
3. Vá em **Authentication** > **Settings**
4. Desabilite **"Enable email confirmations"**
5. Salve as alterações

### 2. Usuário Já Existe com Senha Diferente
Se o usuário `dev@fitsenior.com` já foi criado anteriormente com uma senha diferente, o login falhará.

**Solução: Deletar o usuário e criar novamente**

1. Acesse o [Dashboard do Supabase](https://app.supabase.com)
2. Selecione seu projeto
3. Vá em **Authentication** > **Users**
4. Procure por `dev@fitsenior.com`
5. Delete o usuário
6. Execute o app novamente - ele criará o usuário automaticamente

### 3. Problemas de Rede ou Configuração
Verifique se:
- A URL do Supabase está correta em `SupabaseClient.swift`
- A API Key está correta
- Há conexão com a internet

## O que foi Corrigido no Código

1. **AuthService.swift**:
   - Corrigido o acesso à sessão assíncrona
   - Melhorado o tratamento de erros
   - Adicionados logs para debug
   - Fluxo: Verifica sessão → Tenta login → Se falhar, cria usuário

2. **AuthView.swift**:
   - Campos pré-preenchidos com credenciais padrão
   - Exibição de erros melhorada
   - Tratamento assíncrono correto

3. **SupabaseClient.swift**:
   - Melhor tratamento quando email confirmation está ativado
   - Mensagens de erro mais claras

## Como Testar

1. **Primeira Execução**:
   - Execute o app
   - O app tentará fazer login automaticamente
   - Se o usuário não existir, ele será criado
   - Verifique os logs no console do Xcode

2. **Após Logout**:
   - Os campos já estarão pré-preenchidos
   - Clique em "Entrar"
   - Se houver erro, ele será exibido na tela

3. **Verificar Logs**:
   - Abra o console do Xcode
   - Procure por mensagens como:
     - "Tentando fazer login com usuário padrão..."
     - "Login automático bem-sucedido!"
     - "Usuário criado e autenticado automaticamente!"
     - "ERRO: ..."

## Próximos Passos

Se o problema persistir:

1. Verifique os logs no console do Xcode para ver a mensagem de erro exata
2. Verifique se a confirmação de email está desabilitada no Supabase
3. Delete o usuário no Supabase e tente novamente
4. Verifique se as credenciais do Supabase estão corretas

## Credenciais Padrão

- **Email**: `dev@fitsenior.com`
- **Senha**: `123456`

Essas credenciais são usadas automaticamente na primeira execução e estão pré-preenchidas na tela de login.

