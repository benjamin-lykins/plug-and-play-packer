aws_source_ami_filters = {
  name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
  root-device-type    = "ebs"
  virtualization-type = "hvm"
}

script = "packer/shared/scripts/debian/base.sh"

aws_ssh_username = "ubuntu"

aws_skip_create_ami = true