packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
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
}

source "azure-arm" "windows" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "${var.windows_version}-Datacenter"
  os_type         = "Windows"


  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "win${var.windows_version}-${local.time}"
  managed_image_resource_group_name = "ahs-nprod-nprod01-packer-rg"

   shared_image_gallery_destination {
     resource_group  = "ahs-nprod-nprod01-packer-rg"
     gallery_name    = "packer_gallery"
     image_name      = "windows-${var.windows_version}-${local.time}"
     image_version   = "1.0.${local.time}"
   }

  vm_size = "Standard_DS1_v2"

  // While buildding the image, this resource group is utilized.
  build_resource_group_name = "ahs-nprod-nprod01-packer-builds-rg"

  // These are passed in the pipeline as GitHub Secrets.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id

  // WinRM Connection, this is recommended for Windows, SSH would be the recommendation for Linux distributions.
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "7m"
  winrm_use_ssl  = true
  winrm_username = "packer"
}

build {
  sources = ["source.azure-arm.rhel", "source.azure-arm.windows"]


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
