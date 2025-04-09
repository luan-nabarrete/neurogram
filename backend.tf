terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-teste"
    key            = "terraform.tfstate" # ex: "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    }
}
