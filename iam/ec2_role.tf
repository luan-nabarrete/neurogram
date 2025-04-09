module "ec2_role" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
    #  version = "5.34.0"

    role_name = "ec2-ssm-role"
    create_role = true

    trusted_role_services = [
        "ec2.amazonaws.com"
    ]
    
    custom_role_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
    number_of_custom_role_policy_arns = 1

}

output "ec2_role_arn" {
  value       = module.ec2_role.iam_role_arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-role-profile"
  role = module.ec2_role.iam_role_name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
