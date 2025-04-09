# Pré-requisitos


Terraform instalado (versão recomendada: >= 1.0.0);

AWS CLI instalado;

Permissões adequadas na AWS (via CLI, perfil ou credenciais configuradas);

Backend configurado (caso esteja usando remote state) - bucket S3 referenciado em backend.tf;

Variáveis definidas corretamente no arquivo terraform.tfvars




# Configuração das Variáveis


O arquivo terraform.tfvars é responsável por armazenar os valores das variáveis usadas nos módulos Terraform.

Sempre editar esse arquivo com os valores específicos do seu ambiente (como account_id, nomes de recursos e CIDRs).


# Deploy


1. Inicializar os módulos Terraform

```bash
terraform init
```
Esse comando baixa os módulos, provedores e configura o diretório .terraform/.

2. Visualizar o plano de execução

```bash
terraform plan -var-file="terraform.tfvars"
```

Esse comando mostra todas as alterações que o Terraform fará no ambiente com base nas configurações e variáveis fornecidas.

3. Aplicar o plano e provisionar os recursos

```bash
terraform apply -var-file="terraform.tfvars"
```


# Recursos Criados


VPC e sub-redes (pública/privada)

Security Groups

Buckets S3

EC2 com role e user_data

RDS PostgreSQL

IAM roles e policies



# HTTP Access Apache - Docker

Teste o acesso à aplicação (Apache Web Server) hospedada via Docker na instância EC2 usando o IP público exibido após o deploy:

Exemplo:

    ```bash
    Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

    Outputs:

    ec2_public_ip = "13.219.73.206"
    ```

O teste pode ser feito com o seguinte comando:

```bash
curl -I http://13.219.73.206/
```

Obs: Pode ser acessado o endereço http://13.219.73.206/ pelo navegador.

# SSH Access to EC2 instance

Antes do deploy, atualize a variável "var.ssh_access_ip_address" em terraform.tfvars com o seu endereço IP público + máscara de rede (/32) ou um range de IP's. Obs: ela servirá para configurar a regra de entrada no SG da instância EC2.

Exemplo: 
ssh_access_ip_address    = "201.95.11.254/32"

Após o deploy, usaremos o mesmo endereço IP público exibido e a chave .pem, que também será exibida. Ela será usada para nos autenticar na instância com o usuário padrão das imagens da AWS (ec2-user).

    ```bash
    Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

    Outputs:

    ec2_public_ip = "13.219.73.206"
    private_key_path = "ec2/docker-server-key-dev.pem"
    ```
    
Com essas informações, acessamos a instância com o comando:

    ```bash

    ssh -i ./ec2/docker-server-key-dev.pem ec2-user@13.219.73.206
    ```



# Destroy
Se quiser destruir todos os recursos:

```bash
terraform destroy -var-file="terraform.tfvars"
```




