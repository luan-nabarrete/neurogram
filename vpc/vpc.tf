variable "environment" {
    description = "Deployment env"
    type        = string
}
variable "vpc_cidr" {
    description = "VPC CIDR"
    type        = string
}
variable "azs" {
    description = "AZ's"
    type        = list(string)
}
variable "private_subnets" {
    description = "Private subnets"
    type        = list(string)
}
variable "public_subnets" {
    description = "Publics subnets"
    type        = list(string)
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

    name    = "vpc-${var.environment}"
    cidr    = var.vpc_cidr

    azs             = var.azs
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets

    enable_nat_gateway = true
    enable_vpn_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true

    tags = {
        Terraform = "true"
        Environment = var.environment
        Project = "Teste"
        Name = "vpc-teste"
    }
}


output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
