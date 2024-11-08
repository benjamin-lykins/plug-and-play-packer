# So.
# Issue with Packer is that it does not have some of the flexibility that Terraform has.
# For example, you cannot use for_each or count, so this will be a bit more static for HCP Packer data lookups. 
# Not really a big deal, but something to be aware of.
# So if adding any cloud platform, make sure to uncomment the block. 

locals {
    region = {
        "aws" = "us-east-1"
        "azure"  = "eastus"
        "gce" = "us-central1"
    }
}

# data "hcp-packer-artifact" "aws" {
#   bucket_name  = var.hcp_packer_bucket_name_pull_aws
#   channel_name = var.hcp_packer_channel_name_pull_aws
#   platform     = "aws"
#   region       = lookup(local.region, each.value, "us-east-1")
# }

# data "hcp-packer-artifact" "azure" {
#   bucket_name  = var.hcp_packer_bucket_name_pull_azure
#   channel_name = var.hcp_packer_channel_name_pull_azure
#   platform     = "azure"
#   region       = lookup(local.region, "azure", "eastus")
# }

# data "hcp-packer-artifact" "gce" {
#   bucket_name  = var.hcp_packer_bucket_name_pull_gce
#   channel_name = var.hcp_packer_channel_name_pull_gce
#   platform     = "gce"
#   region       = lookup(local.region, "gce", "us-east1")
# }


