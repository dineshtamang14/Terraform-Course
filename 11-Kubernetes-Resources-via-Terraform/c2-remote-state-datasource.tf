# Terraform Remote State Datasource to reference the data from other project state
data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../09-AWS-EKS-Lab/terraform.tfstate"
  }
}