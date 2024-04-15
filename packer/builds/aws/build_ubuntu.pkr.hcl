packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "run_id" {
  default = "nope"
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-demo-${var.run_id}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  vpc_id        = "vpc-0f5a3ba34424e11fb"
  subnet_id     = "subnet-00d002bd045c8d543"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}
