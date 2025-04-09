variable "aws_profile" {
  description = "AWS profile used to deploy the resources"
  type        = string
}

variable "ssh_access_ip_address" {
  description = "CIDR block to allow SSH access"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_identifier" {
  description = "Database identifier"
  type        = string
}

variable "db_engine" {
  description = "Database engine (e.g., postgres, mysql)"
  type        = string
}

variable "db_instance_class" {
  description = "Database instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Amount of storage (in GB) to allocate for the DB"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_port" {
  description = "Port the database listens on"
  type        = string
  default     = "5432"
}

variable "instance_profile_name" {
  description = "IAM Instance Profile name for EC2"
  type        = string
}

variable "bucket_name" {
  description = "Base name of the S3 bucket (environment suffix will be appended)"
  type        = string
}