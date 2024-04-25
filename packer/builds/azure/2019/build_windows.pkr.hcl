source "azure-arm" "windows" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = var.windows_version == 2022 ? "${var.windows_version}-datacenter-azure-edition" : "${var.windows_version}-datacenter-gensecond"
  os_type         = "Windows"


  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "windows-${var.windows_version}-${local.time}-secure"
  managed_image_resource_group_name = "ben-packer-new-rg"

  // secure_boot_enabled = true
  // vtpm_enabled = true
  // security_type = "TrustedLaunch"

  // shared_image_gallery_destination {
  //   subscription   = var.azure_subscription_id
  //   resource_group = "ben-packer-new-rg"
  //   gallery_name   = "ben_packer_gallery"
  //   image_name     = "windows-${var.windows_version}"
  //   image_version  = "1.0.${local.patch_version}02"
  // }

  vm_size = "Standard_DS1_v2"

  // While build the image, this resource group is utilized.
  build_resource_group_name = "ben-packer-builds-rg"

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

source "azure-arm" "windows2" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = var.windows_version == 2022 ? "${var.windows_version}-datacenter-azure-edition" : "${var.windows_version}-datacenter-gensecond"
  os_type         = "Windows"


  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "windows-${var.windows_version}-${local.time}-secure2"
  managed_image_resource_group_name = "ben-packer-new-rg"

  // secure_boot_enabled = true
  // vtpm_enabled = true
  // security_type = "TrustedLaunch"

  // shared_image_gallery_destination {
  //   subscription   = var.azure_subscription_id
  //   resource_group = "ben-packer-new-rg"
  //   gallery_name   = "ben_packer_gallery"
  //   image_name     = "windows-${var.windows_version}"
  //   image_version  = "1.0.${local.patch_version}02222"
  // }

  vm_size = "Standard_DS1_v2"

  // While build the image, this resource group is utilized.
  build_resource_group_name = "ben-packer-builds-rg"

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

source "azure-arm" "windows3" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = var.windows_version == 2022 ? "${var.windows_version}-datacenter-azure-edition" : "${var.windows_version}-datacenter-gensecond"
  os_type         = "Windows"


  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "windows-${var.windows_version}-${local.time}-secure3"
  managed_image_resource_group_name = "ben-packer-new-rg"

  // secure_boot_enabled = true
  // vtpm_enabled = true
  // security_type = "TrustedLaunch"

  // shared_image_gallery_destination {
  //   subscription   = var.azure_subscription_id
  //   resource_group = "ben-packer-new-rg"
  //   gallery_name   = "ben_packer_gallery"
  //   image_name     = "windows-${var.windows_version}"
  //   image_version  = "1.0.${local.patch_version}02222"
  // }

  vm_size = "Standard_DS1_v2"

  // While build the image, this resource group is utilized.
  build_resource_group_name = "ben-packer-builds-rg"

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

source "azure-arm" "windows4" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = var.windows_version == 2022 ? "${var.windows_version}-datacenter-azure-edition" : "${var.windows_version}-datacenter-gensecond"
  os_type         = "Windows"


  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "windows-${var.windows_version}-${local.time}-secure4"
  managed_image_resource_group_name = "ben-packer-new-rg"

  // secure_boot_enabled = true
  // vtpm_enabled = true
  // security_type = "TrustedLaunch"

  // shared_image_gallery_destination {
  //   subscription   = var.azure_subscription_id
  //   resource_group = "ben-packer-new-rg"
  //   gallery_name   = "ben_packer_gallery"
  //   image_name     = "windows-${var.windows_version}"
  //   image_version  = "1.0.${local.patch_version}02222"
  // }

  vm_size = "Standard_DS1_v2"

  // While build the image, this resource group is utilized.
  build_resource_group_name = "ben-packer-builds-rg"

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
  sources = ["source.azure-arm.windows", "source.azure-arm.windows2", "source.azure-arm.windows3"]

  provisioner "powershell" {
    pause_before = "5s"
    inline = [
      "Write-Host '***** this is a demo message *****'"
    ]
  }

  // provisioner "windows-update" {
  // }


  # Generalising the image
  # This only runs on the Azure source.
  provisioner "powershell" {
    only = ["azure-arm.windows"]
    inline = [
        "# If Guest Agent services are installed, make sure that they have started.",
        "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

        "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
        "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
      ]
  }

   provisioner "powershell" {
    only = ["azure-arm.windows2"]
    inline = [
      "Write-host '=== Azure image build completed successfully ==='",
      "Write-host '=== Generalising the image ... ==='",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /generalize /oobe /quit",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }

   provisioner "powershell" {
    only = ["azure-arm.windows3"]
    inline = [
        "# If Guest Agent services are installed, make sure that they have started.",
        "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

        "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
        "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
      ]
  }

     provisioner "powershell" {
    only = ["azure-arm.windows4"]
    inline = [
      "Write-host '=== Azure image build completed successfully ==='",
      "Write-host '=== Generalising the image ... ==='",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /generalize /oobe /quit",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }
}