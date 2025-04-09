aws_profile              = "tf-user-sandbox"
ssh_access_ip_address    = "201.95.11.254/32"
account_id               = "948881762705"

azs                      = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets          = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
public_subnets           = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]

vpc_cidr                 = "10.0.0.0/16"
environment              = "dev"
aws_region               = "us-east-1"
instance_type            = "t3.micro"

db_identifier            = "teste-db"
db_engine                = "postgres"
db_instance_class        = "db.t3.micro"
db_allocated_storage     = "20"
db_name                  = "postgres"
db_username              = "user123"
db_port                  = "5432"

instance_profile_name    = "ec2-ssm-role"
bucket_name              = "log-devops-teste"
