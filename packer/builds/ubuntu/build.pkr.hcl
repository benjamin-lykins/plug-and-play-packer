build {
  sources = ["source.amazon-ebs.this"]

  provisioner "shell" {
    script = "packer/scripts/debian/${var.role}.sh"
  }

  provisioner "shell" {
    only = ["azure-arm.ubuntu"]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }
}
