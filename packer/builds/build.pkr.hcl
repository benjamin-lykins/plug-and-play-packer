locals {
  build_source = lookup(local.sources, var.cloud_override, ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"])
  sources = {
    all     = ["source.amazon-ebs.this", "source.azure-arm.this", "source.googlecompute.this"]
    aws     = ["source.amazon-ebs.this"]
    azure   = ["source.azure-arm.this"]
    vsphere = ["source.vsphere-iso.this"]
  }
}

build {
  sources = local.build_source

  provisioner "shell" {
    script = var.script
  }
  
  provisioner "shell" {
    only            = ["azure-arm.this"]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -ex"
  }
}
