locals {
  source_ami = {
    "base" = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    "docker" = "ubuntu-${var.ubuntu_version}-${var.role}-*"
    "nginx" = "ubuntu-${var.ubuntu_version}-${var.role}-*"
  }
  ami_name = "ubuntu-${var.ubuntu_version}-${var.role}-${local.time}"
}

data "amazon-ami" "base" {
    filters = {
        name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    }
    region = "us-east-1"
    owners = ["099720109477"]
    most_recent = true
}

data "amazon-ami" "app" {
    filters = {
        "tag:role" = "base"
        "tag:os" = "ubuntu"
    }
    region = "us-east-1"
    owners = ["self"]
    most_recent = true
}


source "amazon-ebs" "this" {
  # Access Configuration
  region = "us-east-1"
  skip_create_ami = true

  ami_name                    = local.ami_name
  instance_type               = "t2.micro"
  source_ami                  = var.role == "base" ? data.amazon-ami.base.id : data.amazon-ami.app.id
  vpc_id                      = "vpc-0586933a9df816025"
  subnet_id                   = "subnet-0567a8db24233d9d7"
  associate_public_ip_address = true

  force_deregister = true
  deprecate_at     = timeadd(timestamp(), "2160h")

  ssh_username = "ubuntu"

  tags = {
    Name        = local.ami_name
    environment = "demo"
    role = "${var.role}"
    os = "ubuntu"
    version = "${var.ubuntu_version}"
  }
}
