# input variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type =  string
  default = "us-east-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "EC2 Instance Key Pair"
  type = string
  default = "application-server-key"
}