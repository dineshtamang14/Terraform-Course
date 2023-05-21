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
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.3"
    }
  }

  # Adding Backend as s3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-ekscluster-state"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-eks-irsa"
  }
}

provider "aws" {
  region = var.aws_region
}