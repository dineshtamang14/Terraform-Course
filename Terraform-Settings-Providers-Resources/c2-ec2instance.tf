# creating ec2 instance resource
resource "aws_instance" "myec2vm" {
   ami = "ami-04581fbf744a7d11f"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["sg-02188a18081f8f208"]
   user_data = file("${path.module}/app-install.sh")
   tags = {
      "Name" = "EC2 Demo"
   }
}

output "ec2_ip" {
   value = "${aws_instance.myec2vm.public_ip}"
   description = "aws instance ip address"
   sensitive = false
   depends_on = []
}