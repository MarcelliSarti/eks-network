# eks-network

Módulo Terraform que centraliza a criação dos recursos de networking (VPC) usados no treinamento EKS.

## O que este módulo cria

- **VPC** com DNS habilitado
- **Internet Gateway**
- **Subnets públicas** (com rota para a internet)
- **Subnets privadas** (com rota para a internet via NAT Gateway)
- **NAT Gateway + Elastic IP** (um por AZ)
- **Subnets de banco de dados** (isoladas, sem acesso à internet)
- **Network ACL** no banco de dados, liberando apenas as portas 3306 (MySQL) e 6379 (Redis) a partir das subnets privadas
- **Parâmetros no SSM Parameter Store** com os IDs da VPC e das subnets, para outros módulos consumirem

## Arquivos

| Arquivo | O que faz |
|---|---|
| `main.tf` | VPC |
| `internet_gateway.tf` | Internet Gateway |
| `public_subnets.tf` | Subnets públicas + rota para internet |
| `private_subnets.tf` | NAT Gateway + subnets privadas |
| `database_subnets.tf` | Subnets de banco de dados + Network ACL |
| `parameter_store.tf` | Publica IDs no SSM |
| `outputs.tf` | Outputs do módulo |
| `variables.tf` | Variáveis de entrada |

## Como usar

```hcl
module "network" {
  source = "git::https://github.com/MarcelliSarti/eks-network.git"

  project_name = "eks-training"
  region       = "us-east-1"
  vpc_cidr     = "10.0.0.0/16"

  public_subnets = [
    { name = "public-a", cidr = "10.0.0.0/24", availability_zone = "us-east-1a" },
    { name = "public-b", cidr = "10.0.1.0/24", availability_zone = "us-east-1b" },
  ]

  private_subnets = [
    { name = "private-a", cidr = "10.0.10.0/24", availability_zone = "us-east-1a" },
    { name = "private-b", cidr = "10.0.11.0/24", availability_zone = "us-east-1b" },
  ]

  database_subnets = [
    { name = "db-a", cidr = "10.0.20.0/24", availability_zone = "us-east-1a" },
    { name = "db-b", cidr = "10.0.21.0/24", availability_zone = "us-east-1b" },
  ]
}
```

> **Importante:** cada subnet privada precisa ter uma subnet pública na mesma Availability Zone — é assim que o módulo descobre qual NAT Gateway usar.

## Variáveis

| Nome | Tipo | Obrigatória |
|---|---|---|
| `project_name` | string | sim |
| `region` | string | sim |
| `vpc_cidr` | string | sim |
| `vpc_additional_cidrs` | list(string) | não |
| `public_subnets` | list(object) | sim |
| `private_subnets` | list(object) | sim |
| `database_subnets` | list(object) | não |

## Outputs

| Nome | Descrição |
|---|---|
| `vpc_id` | ID do parâmetro SSM da VPC |
| `public_subnets` | IDs dos parâmetros SSM das subnets públicas |
| `private_subnets` | IDs dos parâmetros SSM das subnets privadas |
| `database_subnets` | IDs dos parâmetros SSM das subnets de banco de dados |

> Os outputs retornam o ID do **parâmetro no SSM**, não o ID direto do recurso — para pegar o ID real da subnet/VPC, é preciso ler o valor do parâmetro.