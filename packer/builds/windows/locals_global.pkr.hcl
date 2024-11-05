locals {
  timestamp     = formatdate("YYYYMMDDhhmmss", timestamp()) # Year Month Day Hour Minute Second with padding.
  time          = formatdate("YYYYMMDDhhmmss", timestamp()) # Year Month Day Hour Minute Second with padding.
  patch_version = formatdate("YYYYMMDD", timestamp())       # Year Month Day Hour Minute Second with padding.

  ipv4_address = {
    "eastus" = ""
  }


  ipv4_address = {
    2016 = "172.16.123.215"
    2019 = "172.16.123.214"
    2022 = "172.16.123.213"
  }
}

variable "production" {
  description = ""
}