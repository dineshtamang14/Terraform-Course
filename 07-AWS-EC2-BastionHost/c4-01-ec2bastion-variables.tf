# AWS EC2 Instance Terraform Variables
# AWS EC2 Instance Type 
variable "instance_type" {
    description = "AWS EC2 Instance Type"
    type = string 
    default = "t2.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
    description = "AWS EC2 Instance Key"
    type = string
    default = "eks-terraform-key"
}