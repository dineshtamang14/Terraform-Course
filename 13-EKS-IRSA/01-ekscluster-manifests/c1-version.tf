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

  # Adding Backend as s3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-ekscluster-state"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-ekscluster"
  }
}

# provider block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

/*
Note-1: AWS Credentials Profile (profile="default") configured on
$HOME/.aws/credentials
*/