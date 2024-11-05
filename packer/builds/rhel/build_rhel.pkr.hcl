build {
  sources = ["source.azure-arm.rhel"]

  # hcp_packer_registry {
  #   bucket_name = "rhel-9-${var.rhel_minor_version}-base"
  #   description = <<EOT
  #   You can put any arbitrary text here. This is just an example. I will say, 'hi gabe and class.'
  #   EOT
  #   bucket_labels = {
  #     "owner"         = "platform-team"
  #     "os"            = "rhel",
  #     "major_version" = "9",
  #     "minor_version" = "${var.rhel_minor_version}"
  #   }
  #   build_labels = {
  #     "build-time"   = timestamp()
  #     "build-source" = basename(path.cwd)
  #   }
  # }

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
