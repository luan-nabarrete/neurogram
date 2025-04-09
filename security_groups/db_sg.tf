variable "vpc_id" {
    description = "VPC ID"
    type        = string
}

variable "http_sg" {
    description = "HTTP SG"
    type        = string
}

module "db_sg" {
    source          = "terraform-aws-modules/security-group/aws"

    name            = "db-sg"
    description     = "Allow postgres security group access"
    vpc_id          = var.vpc_id

    ingress_with_source_security_group_id = [
        {
            from_port                = 5432
            to_port                  = 5432
            protocol                 = "tcp"
            description              = "Allow Postgres from app SG"
            source_security_group_id = var.http_sg
        }
    ]

    egress_rules    = ["all-all"]

}

output "db_sg_id" {
  value = module.db_sg.security_group_id
}