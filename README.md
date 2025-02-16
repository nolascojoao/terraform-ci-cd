## Resumo de Passos para Configuração de OIDC e Role para GitHub Actions na AWS


OIDC (OpenID Connect) na AWS com GitHub permite que seus workflows do GitHub Actions se autentiquem diretamente na AWS sem a necessidade de armazenar chaves de acesso (IAM Access Keys). Isso melhora a segurança e reduz o risco de vazamento de credenciais.

**Como funciona?**
- GitHub como Identity Provider (IdP): A AWS permite que o GitHub seja configurado como um provedor de identidade OIDC.
- Role IAM com Trust Policy: Você cria uma role IAM na AWS com uma trust policy que permite que tokens OIDC emitidos pelo GitHub sejam usados para autenticação.
- GitHub Actions assume a role: No workflow do GitHub Actions, você configura a autenticação para assumir a role IAM via OIDC, sem precisar de chaves estáticas.


---

## Passo 1: Criar o Identity Provider na AWS

1. **Acesse o console da AWS** e vá para **IAM** (Identity and Access Management).
2. No painel lateral, clique em **Identity providers**.
3. Clique em **Add provider**.
4. Escolha **OpenID Connect** como tipo de provedor.
5. Em **Provider URL**, insira o URL do GitHub Actions:
```bash
https://token.actions.githubusercontent.com
```
6. No campo **Audience**, insira:
```bash
sts.amazonaws.com
```
7. Clique em **Next** e depois em **Add provider**.

## Passo 2: Criar a Role na AWS

1. Vá para o painel de **Roles** no IAM e clique em **Create role**.
2. Selecione **Web identity** como o tipo de confiança.
3. Em **Identity provider**, selecione o provedor que você criou no passo anterior.
```bash
token.actions.githubusercontent.com
```
5. No campo **Audience**, insira:
```bash
sts.amazonaws.com
```
5. Preencher as opções adicionais:
- **GitHub organization** (opcional): Insira o nome da sua organização no GitHub, se aplicável. 
- **GitHub repository** (opcional): Insira o nome do seu repositório no GitHub. 
- **GitHub branch** (opcional): Insira o nome da sua branch,exemplo, `main`.
