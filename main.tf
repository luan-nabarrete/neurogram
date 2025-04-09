provider "aws" {
    region    = var.aws_region
    profile   = var.aws_profile
}

# VPC
module "vpc" {
  source            = "./vpc"
  environment       = var.environment
  vpc_cidr          = var.vpc_cidr
  azs               = var.azs
  private_subnets   = var.private_subnets
  public_subnets    = var.public_subnets
}


# Security Group - HTTP
module "http_sg" {
    source      = "./security_groups"
    vpc_id      = module.vpc.vpc_id
    cidr_block  = var.ssh_access_ip_address
    http_sg     = module.http_sg.http_sg_id
    depends_on  = [module.vpc]
}

# Security Group - DB
module "db_sg" {
    source      = "./security_groups"
    vpc_id      = module.vpc.vpc_id
    http_sg     = module.http_sg.http_sg_id
    cidr_block  = var.ssh_access_ip_address
    depends_on  = [module.http_sg]
}

# IAM Role
module "ec2_role" {
    source          = "./iam"
}

# EC2 Instance
module "ec2_instance" {
    source                  = "./ec2"
    instance_type           = var.instance_type
    environment             = var.environment
    security_group_id       = module.http_sg.http_sg_id
    public_subnets          = module.vpc.public_subnets
    ec2_role                = module.ec2_role.instance_profile_name
    iam_instance_profile    = module.ec2_role.instance_profile_name
    depends_on              = [module.http_sg, module.ec2_role]

}

module "rds" {
  source = "./rds"

  db_identifier         = var.db_identifier
  db_engine             = var.db_engine
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  db_name               = var.db_name
  db_username           = var.db_username
  db_port               = var.db_port
  subnet_ids            = module.vpc.private_subnets
  security_group_id     = [module.db_sg.db_sg_id]
  environment           = var.environment
  depends_on            = [module.db_sg]

}

module "s3_logs_bucket" {
    source          = "./s3"
    bucket_name     = var.bucket_name
    environment     = var.environment
    ec2_role_arn    = module.ec2_role.ec2_role_arn
    account_id      = var.account_id
    depends_on      = [module.ec2_role]
}

output "ec2_public_ip" {
  description = "EC2 instance public IPv4"
  value       = module.ec2_instance.ec2_public_ip
}




