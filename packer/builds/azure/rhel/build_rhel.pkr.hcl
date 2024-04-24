packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    cnspec = {
      source  = "github.com/mondoohq/cnspec"
      version = ">= 10.0.0"
    }
  }
}

source "azure-arm" "rhel" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "redhat"
  image_offer     = "RHEL"
  image_sku       = "9_${var.rhel_minor_version}"

  //  Managed images and resource group.
  managed_image_name                = "rhel-9-3-${local.time}"
  managed_image_resource_group_name = "ben-packer-rg"

  // While building the image, this resource group is utilized.
  build_resource_group_name = "ben-packer-builds-rg"

  // OS 
  vm_size                  = "Standard_DS1_v2"
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

build {
  sources = ["source.azure-arm.rhel"]

  hcp_packer_registry {
    bucket_name = "rhel-9-${var.rhel_minor_version}-base"
    description = <<EOT
    You can put any arbitrary text here. This is just an example. I will say, 'hi gabe and class.'
    EOT
    bucket_labels = {
      "owner"   = "platform-team"
      "os"      = "rhel",
      "major_version" = "9",
      "minor_version" = "${var.rhel_minor_version}"
    }
    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }

  provisioner "cnspec" {
    on_failure      = "continue"
    score_threshold = 85
    sudo {
      active = true
    }
  }

  provisioner "shell" {
   execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
   inline = [
        "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
   ]
   inline_shebang = "/bin/sh -x"
}
}
