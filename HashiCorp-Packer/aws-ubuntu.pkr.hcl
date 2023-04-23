packer {
  // plugins to talk with aws api
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
  source_ami    = "ami-0aa2b7722dc1b5612"
  ssh_username  = "ubuntu"
}

build {
  name    = "my-first-build"
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
