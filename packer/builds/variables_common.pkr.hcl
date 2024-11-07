variable "os" {
  type    = string
  description = "The operating system."
  default = "ubuntu"
}

variable "os_version" {
  type    = string
  description = "The operating system version."
  default = "20.04"
}

variable "role" {
  type    = string
  description = "The role of the image."
  default = "base"
}

