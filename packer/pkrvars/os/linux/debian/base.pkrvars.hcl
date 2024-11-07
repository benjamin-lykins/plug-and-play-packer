aws_source_ami_filters = {
  name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  root-device-type    = "ebs"
  virtualization-type = "hvm"
}

script = "packer/shared/scripts/debian/base.sh"