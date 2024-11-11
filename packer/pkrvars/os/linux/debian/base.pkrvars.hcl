# Ubuntu 24.04 LTS
## AWS
aws_skip_create_ami = true

aws_source_ami_filters = {
  name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
  root-device-type    = "ebs"
  virtualization-type = "hvm"
}
build_shell_scripts = [
  "packer/shared/scripts/debian/base.sh",
  ]
aws_ssh_username = "ubuntu"
os_type = "linux"
