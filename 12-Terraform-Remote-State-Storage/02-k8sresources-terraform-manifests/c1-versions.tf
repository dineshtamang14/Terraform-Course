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

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-ekscluster-state"
    key    = "dev/app1k8s/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-app1k8s"
  }
}