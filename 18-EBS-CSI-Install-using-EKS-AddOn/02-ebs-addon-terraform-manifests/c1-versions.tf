# Terraform Settings Block
terraform {
  # terraform version
  # to allow all the terraform minor versions
  required_version = "~> 1.4"

  # required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.62" # optional but recommanded
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-ekscluster-states"
    key    = "dev/ebs-addon/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-ebs-addon"
  }
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
