# Terraform Remote State Datasource to reference the data from other project state
/*
data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../09-AWS-EKS-Lab/terraform.tfstate"
  }
}
*/

# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  # backend = "local"
  backend = "s3"

  config = {
    # path = "../09-AWS-EKS-Lab/terraform.tfstate"

    bucket = "terraform-ekscluster-state"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}