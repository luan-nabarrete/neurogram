variable "instance_type" {
    description = "AWS instance type"
    type        = string
}
variable "environment" {
    description = "Deployment env"
    type        = string
}
variable "security_group_id" {
    description = "SG id"
    type        = string
}
variable "public_subnets" {
    description = "Public subnets "
    type        = list(string)
}
variable "ec2_role" {
    description = "EC2 role to SSM access"
    type        = string
}
variable "iam_instance_profile" {
  description = "IAM Instance Profile for EC2"
  type        = string
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "docker-instance"

  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnets[0]

  iam_instance_profile   = var.iam_instance_profile

  user_data = file("${path.module}/user_data.sh")

  tags = {
     Environment = var.environment
     Name        = "docker-server"
  }
}