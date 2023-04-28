# Terraform AWS Provider Block
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# getting cluster name from the terraform state of other project
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# getting the cluster id from the terraform state of other project
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# configurration for the kubernetes provider
# Terraform Kubernetes Provider Block
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  #   load_config_file = false
}