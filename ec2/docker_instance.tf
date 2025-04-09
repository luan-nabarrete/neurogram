variable "instance_type" {
    description = "AWS instance type"
    type        = string
}
variable "environment" {
    description = "Deployment env"
    type        = string
}
variable "http_security_group_id" {
    description = "HTTP SG id"
    type        = string
}
variable "ssh_security_group_id" {
    description = "SSH SG id"
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

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "docker-instance-${var.environment}"

  instance_type               = var.instance_type
  ami                         = coalesce(data.aws_ssm_parameter.ami.value, "")
  monitoring                  = true
  vpc_security_group_ids      = [var.http_security_group_id, var.ssh_security_group_id]
  subnet_id                   = var.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  

  iam_instance_profile        = var.iam_instance_profile

  user_data = file("${path.module}/user_data.sh")

  tags = {
     Environment              = var.environment
     Name                     = "docker-server"
  }
  depends_on = [
    aws_key_pair.ec2_key_pair,
    local_file.docker_server_key
  ]

}

resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2-key-${var.environment}"
  public_key = tls_private_key.tls_key.public_key_openssh
}

resource "local_file" "docker_server_key" {
  content         = tls_private_key.tls_key.private_key_pem
  filename        = "${path.module}/docker-server-key-${var.environment}.pem"
  file_permission = "0600"
}

output "private_key_path" {
  value = local_file.docker_server_key.filename
}

output "ec2_public_ip" {
  description = "EC2 instance public IPv4"
  value       = module.ec2_instance.public_ip
}
