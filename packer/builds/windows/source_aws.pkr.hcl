# data "amazon-ami" "this" {
#   filters = {
#     name                = "amazon/Windows_Server-2022-English-Full-Base-*"
#     root-device-type    = "ebs"
#     virtualization-type = "hvm"
#   }
#   most_recent = true
#   owners      = ["801119661308"]
# }


source "amazon-ebs" "windows" {
  # Access Configuration
  region = "us-east-1"

  ami_name      = "windows-${var.windows_version}-${local.time}"
  instance_type = "t2.micro"
  source_ami    = "ami-0324a83b82023f0b3"
  vpc_id = "vpc-0586933a9df816025"
  subnet_id = "subnet-0567a8db24233d9d7"
  associate_public_ip_address = true

  user_data_file   = "packer/builds/bootstrap/bootstrap_win.txt"
  force_deregister = true
  deprecate_at     = timeadd(timestamp(), "2160h")

  communicator  = "winrm"
  winrm_username = "Administrator"
  winrm_insecure = true
  winrm_use_ssl  = true

    tags = {
        Name        = "windows-${var.windows_version}-${local.time}"
        Environment = "demo"
    }
}
