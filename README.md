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



# Destroy
Se quiser destruir todos os recursos:

```bash
terraform destroy -var-file="terraform.tfvars"
```

# HTTP Access Apache - Docker
