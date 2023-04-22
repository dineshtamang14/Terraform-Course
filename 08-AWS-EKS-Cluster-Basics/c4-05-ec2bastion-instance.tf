# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet

# creating key-pair for ec2 instance
resource "aws_key_pair" "dove-key" {
    key_name = "dove-key"
    public_key = file("/home/dinesh/.ssh/id_rsa.pub")
}

module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "${local.name}-BastionHost"
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = "${var.instance_type}"
  # monitoring = true
  subnet_id = "${module.vpc.public_subnets[0]}"
  vpc_security_group_ids      = [module.public_bastion_sg.security_group_id]
  key_name    = aws_key_pair.dove-key.key_name
  tags = "${local.common_tags}"
}