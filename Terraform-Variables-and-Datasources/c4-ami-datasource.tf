# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
    most_recent = true
    owners = ["amazon"]

    # filter for choosing ami id by using ami name
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-gp2"]
    }

    # filter for choosing ebs volume type
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }

    # filter for choosing hvm virtualization
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    # filter for choosing x86 vm
    filter {
        name = "architecture"
        values = ["x86_64"]
    }
}