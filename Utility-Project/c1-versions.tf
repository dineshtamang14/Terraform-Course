terraform {
    # terraform version
    # to allow all the terraform minor versions
    required_version = "~> 1.4"

    # required providers and their versions
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.21" # optional but recommanded
        }
    }

    # Remote backend to store state
    backend "s3" {
      bucket = "dinesh-terraform-state"   # "infrastructure-remote-state"
      key = "Terraform-Course/aws_project.tfstate"
      region = "us-east-1"
    }

    # passing metadata to providers 
    provider_meta "my-provider" {
        hello = "world"
    }
}

# provider block
provider "aws" {
    region = "us-east-1"
    profile = "default"
}