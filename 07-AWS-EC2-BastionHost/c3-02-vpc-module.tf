# AWS Availability Zones Datasource
data "aws_availability_zones" "available" {
  state = "available"

  # To exclude certain availability zones
  # exclude_names = ["us-east-1a", "us-east-1b"]
}

# Create VPC Terraform Module 
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  # version = "~> 4.0"

  # VPC Basic Details
  name = "${local.name}-${var.vpc_name}"
  cidr = "${var.vpc_cidr_block}"

  # azs = "${var.vpc_availability_zones}"
  azs = "${data.aws_availability_zones.available.names}"
  
  private_subnets = "${var.vpc_private_subnets}"
  public_subnets = "${var.vpc_public_subnets}"

  # Database Subnets
  database_subnets = "${var.vpc_database_subnets}"
  create_database_subnet_group = "${var.vpc_create_database_subnet_group}"
  create_database_subnet_route_table = "${var.vpc_create_database_subnet_route_table}"

  # create_database_nat_gateway_route = true
  # create_database_internet_gateway_route = false

  # NAT Gateway - Outbound Communication
  enable_nat_gateway = "${var.vpc_enable_nat_gateway}"
  single_nat_gateway = "${var.vpc_single_nat_gateway}"

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  # Regular Tags
  tags = "${local.common_tags}"
  vpc_tags = "${local.common_tags}"
}