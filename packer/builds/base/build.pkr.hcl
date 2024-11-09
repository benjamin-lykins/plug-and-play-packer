locals {
  # Used to override the cloud source for the build. 
  ## By default this will run on all sources.
  build_source = var.cloud_override #["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"]
}

build {
  sources = local.build_source

  # Ok, no clue why this works, but it does.  I'm going to leave it alone for now.
  # I would expect the opposite logic to be true, but it does not seem to work that way.
  provisioner "shell" {
    only              = var.os_type == "linux" ? ["amazon-ebs.this", "azure-arm.this", "googlecompute.this"] : ["foo.this"]
    scripts           = var.build_shell_scripts
    environment_vars  = var.build_shell_script_environment_vars
    valid_exit_codes        = var.build_shell_script_exit_codes
    execute_command   = var.build_shell_script_execute_command
    expect_disconnect = var.build_shell_script_expect_disconnect
  }

  # Same thing, no clue why this works, but it does.  I'm going to leave it alone for now.
  # I would expect the opposite logic to be true, but it does not seem to work that way.
  provisioner "powershell" {
    only              = var.os_type == "windows" ? ["amazon-ebs.this", "azure-arm.this", "googlecompute.this"] : ["foo.this"]
    scripts           = var.build_powershell_scripts
    environment_vars  = var.build_powershell_script_environment_vars
    use_pwsh          = var.build_powershell_script_use_pwsh
    valid_exit_codes        = var.build_powershell_script_exit_codes
    execute_command   = var.build_powershell_script_execute_command
    # elevated_user     = var.build_powershell_script_elevated_user
    # elevated_password = build.password
    execution_policy  = var.build_powershell_script_execution_policy
  }

  # Azure Deprovisionining
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#deprovision
  provisioner "shell" {
    only = var.os_type == "linux" ? ["azure-arm.this"] : ["foo.this"]
    inline = [
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -ex"
  }

  provisioner "powershell" {
    only = var.os_type == "windows" ? ["azure-arm.this"] : ["foo.this"]

    inline = [
      "# If Guest Agent services are installed, make sure that they have started.",
      "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }

  dynamic "hcp_packer_registry" {
    for_each = var.hcp_packer_registry_push ? [1] : []
    content {
      bucket_name = var.bucket_name
      description = var.bucket_description
      bucket_labels = merge(var.bucket_labels, {
        "role"       = var.role
        "os"         = var.os
        "os_version" = var.os_version
        "os_type"    = var.os_type
        }
      )
      build_labels = merge(var.build_labels, {
        "packer_version" = packer.version
        }
      )
    }
  }
}