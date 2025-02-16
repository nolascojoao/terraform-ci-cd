## Resumo de Passos para Configuração de OIDC e Role para GitHub Actions na AWS

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
