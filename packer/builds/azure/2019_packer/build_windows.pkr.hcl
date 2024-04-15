data "hcp-packer-version" "latest" {
  bucket_name  = "windows-2019-base"
  channel_name = "latest"
}

data "hcp-packer-artifact" "latest" {
  bucket_name         = data.hcp-packer-version.latest.bucket_name
  version_fingerprint = data.hcp-packer-version.latest.fingerprint
  platform            = "azure"
  region              = "East US"
}


source "azure-arm" "windows" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  custom_managed_image_name = data.hcp-packer-artifact.latest.external_identifier
  custom_managed_image_resource_group_name = "packer-rg"

  //  Managed images and resource group.
  managed_image_name                = "windows-${var.windows_version}-${local.time}"
  managed_image_resource_group_name = "packer-rg"

  vm_size                  = "Standard_DS1_v2"
  temp_resource_group_name = "packer-rg-temp-${local.time}"
  location                 = "East US"
  os_type                  = "Windows"

  // These are passed in the pipeline.

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
  sources = ["source.azure-arm.windows"]

  provisioner "powershell" {
    pause_before = "5s"
    inline = [
      "Write-Host '***** this is a demo message *****'"
    ]
  }

  # Generalising the image
  provisioner "powershell" {
    only = ["source.azure-arm.windows"]
    inline = [
      "Write-host '=== Azure image build completed successfully ==='",
      "Write-host '=== Generalising the image ... ==='",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /generalize /oobe /quit",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }

  hcp_packer_registry {
    bucket_name = "windows-${var.windows_version}-base"
    description = <<EOT
      This is a base image for Windows Server ${var.windows_version} Datacenter.
    EOT
    bucket_labels = {
      "owner"   = "ahs"
      "os"      = "windows",
      "version" = "${var.windows_version}",
    }
    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }
}


storage {
  # Binaries 60GB = 60000 MB
  # D Drive
       disk_size = 60000
    }
    storage {
    #  Data 100 GB = 100000 MB
    # E Drive
       disk_size = 100000
    }
    storage {
    # Logs 50 GB = 50000 MB
    # F Drive
       disk_size = 50000
    }
    storage {
    # TempDB Data 25 GB = 25000 MB
    # G Drive
       disk_size = 25000
    }
    storage {
    # TempDB Logs 20 GB = 20000 MB
    # H Drive
       disk_size = 20000
    }
     storage {
    # SSIS Package 5 GB = 5000 MB
    # J Drive
       disk_size = 5000
    }
    storage {
    # Backup 50 GB = 50000 MB
    # K Drive
       disk_size = 50000
    }