variable "db_identifier" {
    description = "DB identifier"
    type        = string
}
variable "db_engine" {
    description = "DB engine"
    type        = string
}
variable "db_instance_class" {
    description = "DB instance class"
    type        = string
}
variable "db_allocated_storage" {
    description = "DB allocated storage"
    type        = string
}
variable "db_name" {
    description = "DB name"
    type        = string
}
variable "db_username" {
    description = "DB username"
    type        = string
}
variable "db_port" {
    description = "DB port"
    type        = string
}
variable "subnet_ids" {
    description = "Private subnet ids"
    type        = list(string)
}
variable "security_group_id" {
    description = "DB security group id"
    type        = list(string)
}
variable "environment" {
    description = "DB environment"
    type        = string
}



module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.db_identifier

  engine            = "postgres"
  engine_version    = "17"

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  manage_master_user_password = true

  iam_database_authentication_enabled = false

  vpc_security_group_ids = var.security_group_id

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval    = "0"
 # monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = false

  tags = {
    Environment = var.environment
  }

  create_db_subnet_group = true
  subnet_ids             = var.subnet_ids

  family = "postgres17"

  major_engine_version = "17"

  deletion_protection = false

  parameters = [
    {
      name  = "log_min_duration_statement"
      value = "2000"
    },
    {
      name  = "work_mem"
      value = "4096"
    }
  ]
}