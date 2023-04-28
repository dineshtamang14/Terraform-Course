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
}