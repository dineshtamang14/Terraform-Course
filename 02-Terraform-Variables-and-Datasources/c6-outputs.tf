# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
   value = "${aws_instance.myec2vm.public_ip}"
   description = "aws instance ip address"
   sensitive = false
   depends_on = []
}

# EC2 Instance Public DNS
output "instance_publicdns" {
   value = "${aws_instance.myec2vm.public_dns}"
   description = "aws instance public dns address"
   sensitive = false
   depends_on = []
}