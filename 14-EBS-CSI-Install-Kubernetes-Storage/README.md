## EBS-CSI-Install-Kubernetes-Storage
1. Review OIDC Provider added as Identity Provider in AWS IAM Service  (already created as part of Section-13 Demo)
2. We are going to install EKS EBS CSI Driver as a [self-managed Add-On](https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi-self-managed-add-on.html) using Terraform
3. Create Terraform configs to install EBS CSI Driver using [HELM Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs) and [HELM Release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release). 
4. TF Configs for EBS CSI install will be at folder `02-ebs-terraform-manifests`. 
5. Key Resources for discission in this section
   - EBS CSI IAM Policy
   - EBS CSI IAM Role
   - Kubernetes EBS CSI Service Account
   - Kubernetes EBS CSI Controller Deployment
   - Kubernetes EBS CSI Node Daemonset
   - Terraform HELM Provider
   - Terraform HELM Release   
   - Terraform HTTP Datasource