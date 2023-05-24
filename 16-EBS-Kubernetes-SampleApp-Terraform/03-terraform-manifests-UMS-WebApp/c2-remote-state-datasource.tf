# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-ekscluster-states"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}