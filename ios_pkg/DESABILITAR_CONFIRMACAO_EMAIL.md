# Como Desabilitar Confirmação de Email no Supabase

Para que o login automático funcione sem precisar confirmar o email, você precisa desabilitar a confirmação de email no Supabase.

## Passo a Passo

1. **Acesse o Dashboard do Supabase**
   - Vá para: https://app.supabase.com
   - Faça login na sua conta

2. **Selecione seu Projeto**
   - Clique no projeto que você está usando (provavelmente o que tem a URL `czplchozqdzvxquopzon.supabase.co`)

3. **Vá para Authentication Settings**
   - No menu lateral esquerdo, clique em **Authentication**
   - Depois clique em **Settings** (ou **Configurações**)

4. **Desabilite Email Confirmation**
   - Procure pela opção **"Enable email confirmations"** ou **"Confirmar email"**
   - **Desmarque** essa opção
   - Role para baixo e clique em **"Save"** ou **"Salvar"**

5. **Pronto!**
   - Agora quando você criar um usuário, ele será autenticado automaticamente
   - Não será necessário confirmar o email

## Importante

⚠️ **Atenção**: Desabilitar a confirmação de email significa que qualquer pessoa que souber o email e senha poderá fazer login. Isso é adequado para desenvolvimento, mas **NÃO é recomendado para produção**.

Para produção, você deve:
- Manter a confirmação de email ativada
- Implementar um fluxo de verificação de email adequado
- Adicionar outras camadas de segurança (2FA, etc.)

## Após Desabilitar

1. **Delete o usuário existente** (se já foi criado):
   - Vá em **Authentication** > **Users**
   - Procure por `dev@fitsenior.com`
   - Clique nos três pontos (...) e selecione **Delete**

2. **Execute o app novamente**
   - O app criará o usuário automaticamente
   - O login funcionará sem precisar confirmar email

## Verificação

Após desabilitar, você pode testar:
- O app deve fazer login automaticamente na primeira execução
- Não deve aparecer mais a mensagem de erro sobre confirmação de email
- O usuário `dev@fitsenior.com` deve conseguir fazer login normalmente

