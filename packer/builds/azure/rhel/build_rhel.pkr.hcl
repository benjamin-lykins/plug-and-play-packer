variable "azure_subscription_id" {
  type        = string
  description = "The subscription id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_tenant_id" {
  type        = string
  description = "The tenant id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_client_id" {
  type        = string
  description = "The client id of the service principal, store in GitHub secrets"
  default     = ""
}

variable "azure_client_secret" {
  type        = string
  description = "The client secret of the service principal, store in GitHub secrets"
  default     = ""
}


packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

locals {
  time          = formatdate("YYYYMMDDhhmmss", timestamp()) # Year Month Day Hour Minute Second with padding.
  patch_version = formatdate("YYYYMMDD", timestamp())       # Year Month Day Hour Minute Second with padding.
}

source "azure-arm" "rhel" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "redhat"
  image_offer     = "RHEL"
  image_sku       = "9_3"

  //  Managed images and resource group.
  managed_image_name                = "rhel-9-3-${local.time}"
  managed_image_resource_group_name = "packer-rg"

  vm_size                  = "Standard_DS1_v2"
  temp_resource_group_name = "packer-rg-temp-${local.time}"
  location                 = "East US"
  os_type                  = "linux"

  // // Create a managed image and share it to a gallery
  // shared_image_gallery_destination {
  //     subscription        = "${var.azure_subscription_id}"
  //     gallery_name        = "packer_acg"
  //     image_name          = "windows-2019-base"
  //     image_version       = "1.0.${local.minor_version}"
  //     replication_regions = ["Australia East", "Australia Southeast"]
  //     resource_group      = "packer-rg"
  //   }

  // These are passed in the pipeline.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id

  // WinRM Connection, this is recommended for Windows, SSH would be the recommendation for Linux distributions.
}

source "azure-arm" "rhel2" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "redhat"
  image_offer     = "RHEL"
  image_sku       = "9_2"

  //  Managed images and resource group.
  managed_image_name                = "rhel-9-3-${local.time}"
  managed_image_resource_group_name = "packer-rg"

  vm_size                  = "Standard_DS1_v2"
  temp_resource_group_name = "packer-rg-temp-${local.time}"
  location                 = "East US"
  os_type                  = "linux"

  // // Create a managed image and share it to a gallery
  // shared_image_gallery_destination {
  //     subscription        = "${var.azure_subscription_id}"
  //     gallery_name        = "packer_acg"
  //     image_name          = "windows-2019-base"
  //     image_version       = "1.0.${local.minor_version}"
  //     replication_regions = ["Australia East", "Australia Southeast"]
  //     resource_group      = "packer-rg"
  //   }

  // These are passed in the pipeline.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id

  // WinRM Connection, this is recommended for Windows, SSH would be the recommendation for Linux distributions.
}

build {
  sources = ["source.azure-arm.rhel", "source.azure-arm.rhel2"]


  hcp_packer_registry {
    bucket_name = "rhel-base"
    description = <<EOT
    You can put any arbitrary text here. This is just an example. I will say, 'hi gabe and class.'
    EOT
    bucket_labels = {
      "owner"   = "platform-team"
      "os"      = "rhel",
      "version" = "9",
    }
    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }
}
