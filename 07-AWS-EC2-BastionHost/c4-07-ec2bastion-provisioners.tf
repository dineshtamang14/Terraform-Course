# create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
    depends_on = [module.ec2_public]
    # Connection Block for Provisioners to connect to EC2 Inst
    connection {
        type = "ssh"
        host = "${aws_eip.bastion_eip.public_ip}"
        user = "ec2-user"
        password = ""
        private_key = file("/home/dinesh/Desktop/aws-projects/application-server-key.pem")
    }

    ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
    provisioner "file" {
        source = "/home/dinesh/Desktop/aws-projects/application-server-key.pem"
        destination = "/tmp/application-server-key.pem"
    }

    ## remote-exec Provisioner: using remote-exec provisioner fix the private key permissions
    provisioner "remote-exec" {
        inline = [
            "sudo chmod 400 /tmp/application-server-key.pem"
        ]
    }

    ## Local Exec Provisioner: using local-exec provisioner (Creation-Time Provisioner - Triggered during create Resource)
    # command to store vpc id in local file
    provisioner "local-exec" {
        command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"

        # working directory for command to run and save file on local machine
        working_dir = "local-exec-output-files"
        # on_failure = continue
    }
}