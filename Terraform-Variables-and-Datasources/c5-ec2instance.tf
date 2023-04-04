# creating ec2 instance resource
resource "aws_instance" "myec2vm" {
   ami = "${data.aws_ami.amzlinux2.id}"
   instance_type = "${var.instance_type}"
   vpc_security_group_ids = ["${aws_security_group.vpc-ssh.id}", "${aws_security_group.vpc-web.id}"]
   user_data = file("${path.module}/app-install.sh")
   key_name = "${var.instance_keypair}"
   tags = {
      "Name" = "EC2 Demo"
   }
}