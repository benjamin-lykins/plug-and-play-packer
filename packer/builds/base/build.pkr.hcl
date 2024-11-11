locals {
  # Used to override the cloud source for the build. 
  ## By default this will run on all sources.
  build_source = var.cloud_override #["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"]
}

build {
  sources = local.build_source

# Probably not the best method to get this to work, but it works for now. 
  provisioner "shell" {
    only              = var.os_type == "linux" ? ["amazon-ebs.this", "azure-arm.this", "googlecompute.this"] : ["foo.this"]
    scripts           = var.build_shell_scripts
    environment_vars  = var.build_shell_script_environment_vars
    valid_exit_codes        = var.build_shell_script_exit_codes
    execute_command   = var.build_shell_script_execute_command
    expect_disconnect = var.build_shell_script_expect_disconnect
  }

# Probably not the best method to get this to work, but it works for now. 
  provisioner "powershell" {
    only              = var.os_type == "windows" ? ["amazon-ebs.this", "azure-arm.this", "googlecompute.this"] : ["foo.this"]
    scripts           = var.build_powershell_scripts
    environment_vars  = var.build_powershell_script_environment_vars
    use_pwsh          = var.build_powershell_script_use_pwsh
    valid_exit_codes        = var.build_powershell_script_exit_codes
    execute_command   = var.build_powershell_script_execute_command
    elevated_user     = build.User
    elevated_password = build.Password
    execution_policy  = var.build_powershell_script_execution_policy
  }

  # AWS Deprovisionining
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#deprovision
  provisioner "shell" {
    only = var.os_type == "linux" ? ["amazon-ebs.this"] : ["foo.this"]
    script = "packer/shared/scripts/${var.os_distribution}/deprovision-aws.sh"
  }

  provisioner "powershell" {
    only = var.os_type == "windows" ? ["amazon-ebs.this"] : ["foo.this"]
    script = "packer/shared/scripts/windows/deprovision-aws.sh"
  }


  # Azure Deprovisionining
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#deprovision
  provisioner "shell" {
    only = var.os_type == "linux" ? ["azure-arm.this"] : ["foo.this"]
    script = "packer/shared/scripts/${var.os_distribution}/deprovision-azure.sh"
  }

  provisioner "powershell" {
    only = var.os_type == "windows" ? ["azure-arm.this"] : ["foo.this"]
    script = "packer/shared/scripts/windows/deprovision-azure.ps1"
  }

  # Google Deprovisionining
  ## https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#deprovision
  provisioner "shell" {
    only = var.os_type == "linux" ? ["googlecompute.this"] : ["foo.this"]
    script = "packer/shared/scripts/${var.os_distribution}/deprovision-google.sh"
  }

  provisioner "powershell" {
    only = var.os_type == "windows" ? ["googlecompute.this"] : ["foo.this"]
    script = "packer/shared/scripts/windows/deprovision-google.ps1"
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