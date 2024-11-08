variable "os" {
  type        = string
  description = "The operating system."
  default     = "ubuntu"
}

variable "os_type" {
  type        = string
  description = "The operating system version."
  default     = "linux"
}

variable "os_version" {
  type        = string
  description = "The operating system version."
  default     = "20.04"
}

variable "role" {
  type        = string
  description = "The role of the image."
  default     = "base"
}

variable "cloud_override" {
  type        = string
  description = "Overrides for cloud-specific variables."
  default     = "aws"
}

variable "script" {
  type        = string
  description = "The script to run."
  default     = "packer/shared/scripts/ubuntu/base.sh"
}