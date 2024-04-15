packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    cnspec = {
      version = ">= 10.0.0"
      source  = "github.com/mondoohq/cnspec"
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
  vpc_id        = "vpc-05d04ab6846230e99"
  subnet_id     = "subnet-0265fdbb67d71a568"
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

  provisioner "cnspec" {
  on_failure          = "continue"
  score_threshold     = 85
  sudo {
    active = true
  }
}
}
