# Ubuntu 24.04 LTS
## AWS

aws_skip_create_ami = true
aws_communicator = "winrm"

aws_source_ami_filters = {
  name                = "Windows_Server-2019-English-Full-Base-*"
  root-device-type    = "ebs"
  virtualization-type = "hvm"
}

build_powershell_scripts = [
  "packer/shared/scripts/windows/base.ps1",
  ]

aws_winrm_username = "Administrator"

os_type = "windows"

aws_user_data_file = "packer/shared/bootstrap/bootstrap_win.txt"
