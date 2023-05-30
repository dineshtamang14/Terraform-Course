packer {
  required_plugins {
    amazon = {
      version = "~> 1.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

// builder configurations
source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.project}-app"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username            = "ubuntu"
  temporary_key_pair_type = "ed25519"
}


build {
  name    = "${var.project}-app"
  sources = ["source.amazon-ebs.ubuntu"]

  // provisioner configuration
  provisioner "shell" {
    script = "userdata/setup.sh"
  }

  provisioner "file" {
    source      = "userdata/app.zip"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo rm -rf /var/www/html/*",
      "sudo unzip /tmp/app.zip -d /var/www/html",
      "sudo mv /var/www/html/templatemo_584_pod_talk/* /var/www/html"
    ]
  }

  // post processes 
  post-processor "vagrant" {} // first post-process passes the output as argument to second post processor
  post-processor "compress" {}
}
