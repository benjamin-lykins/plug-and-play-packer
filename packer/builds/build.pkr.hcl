locals {
  build_source = lookup(local.sources, var.cloud_override, ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"])
  sources = {
    all     = ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"]
    aws     = ["source.amazon-ebs.this"]
    azure   = ["source.azure-arm.this"]
    gcp     = ["source.googlecompute.this"]
  }
}


# Linux Builds
build {
  sources = local.build_source

# Ok, no clue why this works, but it does.  I'm going to leave it alone for now.
# I would expect the opposite logic to be true, but it does not seem to work that way.
  provisioner "shell" {
    only = var.os_type != "linux" ? ["*.this"] : [""]
    scripts = var.scripts
  }

# Same thing, no clue why this works, but it does.  I'm going to leave it alone for now.
# I would expect the opposite logic to be true, but it does not seem to work that way.
  provisioner "powershell" {
    only = var.os_type != "windows" ? ["*.this"] : [""]
    script = var.scripts
  }
  
  # provisioner "shell" {
  #   only            = ["azure-arm.this"]
  #   execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
  #   inline = [
  #     "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
  #   ]
  #   inline_shebang = "/bin/sh -ex"
  # }

  # dynamic "hcp_packer_registry" {
  #   for_each = var.hcp_packer_registry_enabled ? [1] : []
  #   content {
  #     bucket_name = var.bucket_name
  #     description = var.bucket_description
  #     bucket_labels = {
  #       "role" : var.role,
  #       "os" : var.os,
  #       "team" : "platform",
  #     }
  #     build_labels = {
  #       "packer_version" : packer.version,
  #     }
  #   }
  # }
}