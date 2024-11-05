

build {
  sources = ["source.azure-arm.windows"]


  provisioner "powershell" {
    inline = ["dir c:/"]
  }


  provisioner "powershell" {
    only = ["azure-arm.windows"]
    inline = [
      "# If Guest Agent services are installed, make sure that they have started.",
      "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }

  # hcp_packer_registry {
  #   bucket_name = "windows-${var.windows_version}-base"
  #   description = <<EOT
  #     This is a base image for Windows Server ${var.windows_version} Datacenter.
  #   EOT
  #   bucket_labels = {
  #     "os"      = "windows",
  #     "version" = "${var.windows_version}",
  #   }
  #   build_labels = {
  #     "build-time"   = timestamp()
  #     "build-source" = basename(path.cwd)
  #   }
  # }
}