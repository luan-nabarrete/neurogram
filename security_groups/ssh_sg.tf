module "ssh_sg" {
    source          = "terraform-aws-modules/security-group/aws"

    name            = "ssh_sg"
    description     = "Allow postgres security group access"
    vpc_id          = var.vpc_id

    ingress_with_cidr_blocks = [
        {
            from_port                = 22
            to_port                  = 22
            protocol                 = "tcp"
            description              = "Allow SSH access from my IP"
            cidr_blocks              = var.cidr_block
        }
    ]

    egress_rules    = ["all-all"]

}

output "ssh_sg_id" {
  value = module.ssh_sg.security_group_id
}