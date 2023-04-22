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
  ami_name      = "my-first-packer-image"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-007855ac798b5175e"
  ssh_username  = "ubuntu"
}

build {
  name   = "my-first-build"
  sources = ["source.amazon-ebs.ubuntu"]

  // provisioner configuration
  provisioner "shell" {
    inline = [
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install nginx vim nano fish nmap wget -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow proto tcp from any to port 22,80,443",
      "echo 'y' | sudo ufw enable"
    ]
  }

  // post processes 
  post-processor "vagrant" {} // first post-process passes the output as argument to second post processor
  post-processor "compress" {}
}
