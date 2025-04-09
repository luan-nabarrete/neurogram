variable "cidr_block" {
    type        = string
    description = "IP Address to access instance via SSH"
}




module "http_sg" {
    source          = "terraform-aws-modules/security-group/aws"

    name            = "http-sg"
    description     = "Allow HTTP security group access"
    vpc_id          = var.vpc_id

    
    ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP from anywhere"
      cidr_blocks = "0.0.0.0/0"
    }
  ]


    egress_rules    = ["all-all"]

}

output "http_sg_id" {
  value = module.http_sg.security_group_id
}