# EBS Builder Configuration

variable "aws_skip_create_ami" {
  type        = bool
  description = "Skip creating the AMI, for testing builds."
  default     = false
}

# AMI Configuration

variable "aws_ami_regions" {
  type        = list(string)
  description = "The regions to replicate the AMI to."
  default     = null
}

variable "aws_ami_tags" {
  type        = map(string)
  description = "Additional tags to apply to the AMI."
  default     = {}
}

variable "aws_force_deregister" {
  type        = bool
  description = "Force deregister the AMI if it already exists."
  default     = null
}

variable "aws_force_delete_snapshot" {
  type        = bool
  description = "Force delete the snapshot if deregistering."
  default     = false
}

variable "aws_deprecate_at" {
  type        = string
  description = "Hours to deprecate the image. (Example: '2160h' = 90 days)"
  default     = null
}

# Access Configuration
## For AWS Access Key, AWS Secret Key, and AWS Region, I am using env() function to get the values from the environment variables.
## This is a simpler approach which is similar to the plugin and terraform provider method of accessing AWS.
## If these are already set locally or in a pipeline, then it will continue to work. 

variable "aws_access_key" {
  type        = string
  description = "The AWS access key, if an env variable exists it will use it."
  default     = env("AWS_ACCESS_KEY_ID")

  validation {
    condition     = length(var.aws_access_key) > 0
    error_message = <<EOF
The aws_access_key var is not set: make sure to at least set the AWS_ACCESS_KEY_ID env var.
EOF
  }
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret key, if an env variable exists it will use it."
  default     = env("AWS_SECRET_ACCESS_KEY")
  validation {
    condition     = length(var.aws_secret_key) > 0
    error_message = <<EOF
The aws_secret_key var is not set: make sure to at least set the AWS_SECRET_ACCESS_KEY env var.
EOF
  }
}

variable "aws_build_region" {
  type        = string
  description = "The region to build the AMI in."
  default     = env("AWS_DEFAULT_REGION")
  validation {
    condition     = length(var.aws_build_region) > 0
    error_message = <<EOF
The aws_build_region var is not set: make sure to at least set the AWS_DEFAULT_REGION env var.
To fix this you could also set the aws_region variable from the arguments, for example:
$ packer build -var=aws_build_region=us-east-1...
EOF
  }
}

# Run Configuration

variable "aws_instance_type" {
  type        = string
  description = "The instance type to use for the build."
  default     = "t2.micro"
}

variable "aws_source_ami_filters" {
  type        = map(string)
  description = "The filters to use when searching for the source AMI."
  default     = {}
}

variable "aws_source_ami_most_recent" {
  type        = bool
  description = "The most recent source AMI."
  default     = true
}

variable "aws_source_ami_owners" {
  type        = list(string)
  description = "The owners of the source AMI."
  default     = ["amazon"]
}

variable "aws_source_ami_id" {
  type        = string
  description = "Specifies the source AMI to use for the instance. If using aws_source_ami_filters, this will be ignored."
  default     = ""
}

variable "aws_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance."
  default     = true
}

variable "aws_user_data_file" {
  type        = string
  description = "The user data file to use for the instance."
  default     = null
}

variable "aws_vpc_id" {
  type        = string
  description = "The VPC ID to use for the instance."
}

variable "aws_subnet_id" {
  type        = string
  description = "The subnet ID to use for the instance."
}

# Communicator Configuration

variable "aws_communicator" {
  type        = string
  description = "The communicator to use for the instance."
  default     = "ssh"
}

## SSH Configuration
### AWS has default usernames on their base images.
### https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html#ami-default-user-names
/*
    For an Amazon Linux AMI, the username is ec2-user.
    For a CentOS AMI, the username is centos or ec2-user.
    For a Debian AMI, the username is admin.
    For a Fedora AMI, the username is fedora or ec2-user.
    For a RHEL AMI, the username is ec2-user or root.
    For a SUSE AMI, the username is ec2-user or root.
    For an Ubuntu AMI, the username is ubuntu.
    For an Oracle AMI, the username is ec2-user.
    For a Bitnami AMI, the username is bitnami.
*/

variable "aws_ssh_username" {
  type        = string
  description = "The SSH username to use for the instance."
  default     = "ec2-user"
}

variable "aws_ssh_password" {
  type        = string
  description = "The SSH password to use for the instance."
  default     = null
}

variable "aws_ssh_timeout" {
  type        = string
  description = "The SSH timeout to use for the instance. Default is 5m."
  default     = null
}

## WinRM Configuration
## Basing on this config:
## https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#connecting-to-windows-instances-using-winrm

variable "aws_winrm_username" {
  type        = string
  description = "The WinRM username to use for the instance. For AWS images, the default is Administrator."
  default     = "Administrator"
}

variable "aws_winrm_insecure" {
  type        = bool
  description = "The WinRM insecure flag to use for the instance."
  default     = true
}

variable "aws_winrm_use_ssl" {
  type        = bool
  description = "The WinRM use SSL flag to use for the instance."
  default     = true
}