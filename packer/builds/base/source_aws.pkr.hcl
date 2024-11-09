locals {
  ami_name = "${var.os}-${var.os_version}-${var.role}-${local.time}"
}

source "amazon-ebs" "this" {
  # Full Documentation
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs

  # EBS Builder Configuration
  ## Nothing much I will put in here for now. See the additional options in the link below.
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#ebs-specific-configuration-reference
  skip_create_ami = var.aws_skip_create_ami #false

  # AMI Configuration
  ## Only most common options I have used in the past.
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#ami-configuration
  ami_name    = local.ami_name      #${var.os}-${var.version}-${var.role}-${local.time}
  ami_regions = var.aws_ami_regions #null
  tags = merge(var.aws_ami_tags,
    {
      "name"           = local.ami_name
      "role"           = var.role
      "os"             = var.os
      "os_version"     = var.os_version
      "build_date"     = timestamp()
      "packer_version" = "${packer.version}"
    }
  )
  force_deregister      = var.aws_force_deregister                                                         #null
  force_delete_snapshot = var.aws_force_deregister != null ? var.aws_force_delete_snapshot : null          #false
  deprecate_at          = var.aws_deprecate_at != null ? timeadd(timestamp(), var.aws_deprecate_at) : null #null

  # Access Configuration
  ## Only using simpler approach with access_key and secret_key.
  ## There are a lot of other ways to configure access to AWS, use the approach you are most comfortable with, or able to. 
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#access-configuration

  access_key = var.aws_access_key   #env("AWS_ACCESS_KEY_ID")
  secret_key = var.aws_secret_key   #env("AWS_SECRET_ACCESS_KEY")
  region     = var.aws_build_region #env("AWS_DEFAULT_REGION")

  # Run Configuration
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#run-configuration
  instance_type = var.aws_instance_type #t2.micro

  dynamic "source_ami_filter" {
    for_each = var.aws_source_ami_filters != {} ? [1] : []
    content {
      filters     = var.aws_source_ami_filters
      most_recent = var.aws_source_ami_most_recent
      owners      = var.aws_source_ami_owners
    }
  }

  source_ami = var.aws_source_ami_filters == {} ? var.aws_source_ami_id : null

  ## If using a non-default VPC, public IP addresses are not provided by default. 
  ## If you want your instance to be assigned a public IP address, you must set this value to true.
  ## If building in a private subnet, then set this to false. 
  associate_public_ip_address = var.aws_associate_public_ip_address #true
  user_data_file              = var.aws_user_data_file              #null
  vpc_id                      = var.aws_vpc_id                      #Needs to be set
  subnet_id                   = var.aws_subnet_id                   #Needs to be set

  # Communicator Configuration
  ## With Linux SSH would be the most common communicator.
  ## With Windows WinRM would be the most common communicator.
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#communicator-configuration
  communicator = var.aws_communicator #ssh

  ## SSH Configuration
  ## If using SSH as the communicator
  ssh_username = var.aws_communicator == "ssh" ? var.aws_ssh_username : null
  ssh_password = var.aws_communicator == "ssh" ? var.aws_ssh_password : null
  ssh_timeout  = var.aws_communicator == "ssh" ? var.aws_ssh_timeout : null

  ## WinRM Configuration
  ## If using WinRM as the communicator
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#connecting-to-windows-instances-using-winrm
  winrm_username = var.aws_communicator == "winrm" ? var.aws_winrm_username : null
  winrm_insecure = var.aws_communicator == "winrm" ? var.aws_winrm_insecure : null
  winrm_use_ssl  = var.aws_communicator == "winrm" ? var.aws_winrm_use_ssl : null
}
