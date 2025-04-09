variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "environment" {
  description = "env name"
  type        = string
}

variable "ec2_role_arn" {
    description = "Role ARN"
    type        = string
}

variable "account_id" {
    description = "Account ID number"
    type        = string
}


module "s3_logs_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.bucket_name}-${var.environment}"

  #attach_policy = true
  #policy        = jsonencode({
  #"Version": "2012-10-17",
  #"Statement": [
  #  {
  #    "Sid": "AllowFullAccessToEC2RoleAndAccountRoot",
  #    "Effect": "Allow",
  #    "Principal": "*",
  #    "Action": "s3:*",
  #    "Resource": [
  #      "arn:aws:s3:::${var.bucket_name}-${var.environment}",
  #      "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
  #    ],
  #    "Condition": {
  #      "StringEquals": {
  #        "aws:PrincipalArn": [
  #          "${var.ec2_role_arn}",
  #          "arn:aws:iam::${var.account_id}:root"
  #        ]
  #      }
  #    }
  #  },
#    {
#      "Sid": "DenyAccessToOthers",
#      "Effect": "Deny",
#      "Principal": "*",
#      "Action": "s3:*",
#      "Resource": [
#        "arn:aws:s3:::${var.bucket_name}-${var.environment}",
#        "arn:aws:s3:::${var.bucket_name}-${var.environment}/*"
#      ],
#      "Condition": {
#        "StringNotEquals": {
#          "aws:PrincipalArn": [
#            "${var.ec2_role_arn}",
#            "arn:aws:iam::${var.account_id}:root"
#          ]
#        }
#      }
#    }
#  ]
#})

  tags = {
    Environment = var.environment
    Name        = "meu-logs-${var.environment}"
  }
}
