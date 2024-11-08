locals {
  platform = {
    "amazon-ebs"    = "aws"
    "azure-arm"     = "azure"
    "googlecompute" = "gcp"
  }
  region = {
    "amazon-ebs"    = "aws"
    "azure-arm"     = "azure"
    "googlecompute" = "gcp"
  }
}


data "hcp-packer-artifact" "this" {
  for_each     = var.hcp_packer_registry_pull ? var.cloud_override : []
  bucket_name  = var.hcp_packer_bucket_name_pull
  channel_name = var.hcp_packer_channel_name_pull
  platform     = lookup(local.platform, each.value, "")
  region       = lookup(local.region, "region", "")
}


