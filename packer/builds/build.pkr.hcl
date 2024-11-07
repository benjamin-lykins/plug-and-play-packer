locals {
  clouds = {
    all   = ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"]
    aws   = ["source.amazon-ebs.this"]
    azure = ["source.azure-arm.this"]
    gcp   = ["source.googlecompute.this"]
  }
  sources = lookup(local.clouds, var.cloud_override, ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"])
}

build {
  sources = local.sources

  provisioner "shell" {
    script = "packer/scripts/debian/${var.role}.sh"
  }

  provisioner "shell" {
    only            = ["azure-arm.this"]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -ex"
  }

  dynamic "hcp-packer" {
    for_each = var.post_processors
    content {
      name = post-processor.value
    }
  }
}
