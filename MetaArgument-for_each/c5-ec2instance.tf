# Availability Zones DataSource
data "aws_availability_zones" "my_azones" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# creating ec2 instance resource
resource "aws_instance" "myec2vm" {
   ami = "${data.aws_ami.amzlinux2.id}"
   instance_type = "${var.instance_type}"
   vpc_security_group_ids = ["${aws_security_group.vpc-ssh.id}", "${aws_security_group.vpc-web.id}"]
   user_data = file("${path.module}/app-install.sh")
   key_name = "${var.instance_keypair}"

   # Create EC2 Instance in all Availabilty Zones of a VPC
   for_each = toset(data.aws_availability_zones.my_azones.names)
   availability_zone = "${each.key}"

   # You can also use each.value because for list items each.key == each.value
   tags = {
      "Name" = "For-Each-Demo-${each.value}"
   }
}