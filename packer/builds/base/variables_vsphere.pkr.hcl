 
// Communicator
 
 variable "vsphere_communicator" {
  type        = string
  description = "The communicator to use for the instance."
  default     = "ssh"
}



 
// General
 
variable "os_type" {
  description = "The operating system type. Linux or Windows."
  type        = string
  default     = "linux"
 
  validation {
    condition     = var.os_type == "linux" || var.os_type == "windows"
    error_message = "The operating system type must be either 'linux' or 'windows'."
  }
}
 
variable "os" {
  description = "The operating system name."
  type        = string
  default     = "rhel"
}
 
variable "os_version" {
  description = "The operating system version."
  type        = string
  default     = "9"
}
 
variable "role" {
  description = "The role of the image."
  type        = string
  default     = "base"
}
 
variable "vsphere_shutdown_command" {
  description = "Command to shutdown the VM"
 type        = string
  default     = null
}
 
variable "vsphere_configuration_parameters" {
  description = "Configuration parameters for the VM."
  type        = map(string)
  default     = null
}
 
 
// Virtual machine
 
variable "vsphere_vm_name" {
  type    = string
  default = "rhel-9-base"
}
 
variable "vsphere_guest_os_type" {
  type    = string
  default = "rhel9_64Guest"
}
 
variable "vsphere_vm_version" {
  description = "The virtual machine hardware version."
  type        = number
  default     = 17
}
 
// vSphere
 
variable "vsphere_vcenter_server" {
  type    = string
  default = "vcenter.server.com"
}
 
variable "vsphere_datacenter" {
  type    = string
  default = "datacenter"
}
 
variable "vsphere_cluster" {
  type    = string
  default = "cluster"
}
 
variable "vsphere_datastore" {
  type    = string
  default = "datastore"
}
 
variable "vsphere_folder" {
  type    = string
  default = "templates"
}
 
variable "vsphere_resource_pool" {
  type    = string
  default = "Image Works - AIT 70805"
}
 
variable "vsphere_convert_to_template" {
  type    = string
  default = "true"
}
 
// Removeables
 
variable "vsphere_iso_checksum" {
  type    = string
  default = null
}
 
variable "vsphere_iso_paths" {
  type    = list(string)
  default = null
}
 
variable "vsphere_iso_url" {
  type    = string
  default = null
}
 
variable "vsphere_floppy_dirs" {
  description = "List of directories to copy to the floppy disk."
  type        = list(string)
  default     = null
}
 
variable "vsphere_floppy_files" {
  description = "List of files to copy to the floppy disk."
  type        = list(string)
  default     = null
}
 
variable "vsphere_floppy_content_enabled" {
  description = "If using floppy content for Windows builds."
  type        = bool
  default     = false
}
 
// Hardware
variable "vsphere_cpus" {
  type    = number
  default = 1
}
 
variable "vsphere_cpu_cores" {
  type    = number
  default = 1
}
 
variable "vsphere_cpus_hotplug_enabled" {
  description = "Whether to enable hotplug for CPU."
  type        = bool
  default     = false
}
 
variable "vsphere_ram" {
  type    = number
  default = 2048
}
 
variable "vsphere_ram_hotplug_enabled" {
  description = "Whether to enable hotplug for RAM."
  type        = bool
  default     = false
}
 
variable "vsphere_firmware" {
  type    = string
  default = "efi"
}
 
variable "vsphere_network" {
  type    = string
  default = "network"
}
 
variable "vsphere_network_card" {
  type    = string
  default = "vmxnet3"
}
 
variable "vsphere_disk_controller_type" {
  type    = list(string)
  default = ["pvscsi"]
}
 
variable "vsphere_storage_config" {
  description = "Configuration for vSphere storage."
  type = map(object({
    disk_size             = number
    disk_thin_provisioned = bool
  }))
  default = {
    "os" = {
      disk_size             = 50000
      disk_thin_provisioned = true
    }
    "data" = {
      disk_size             = 10000
      disk_thin_provisioned = true
    }
  }
}
 
// Boot
 
variable "vsphere_http_directory" {
  type    = string
  default = "packer/shared/bootstrap"
}
 
variable "vsphere_boot_command" {
  type    = list(string)
  default = null
}
 
variable "vsphere_boot_wait" {
  type    = string
  default = "30s"
}
 
// Post Processing
 
variable "vsphere_remove_cdrom" {
  type    = string
  default = "true"
}
 
// HCP Packer
 
variable "hcp_packer_enabled" {
  description = "Enables the use of the HCP Packer Registry."
  type        = bool
  default     = false
}
 
variable "vsphere_hcp_bucket_name" {
  description = "The name of the bucket."
  type        = string
  default     = "hcp-packer-bucket"
}
 
variable "vsphere_hcp_bucket_description" {
  description = "The description of the bucket."
  type        = string
  default     = "HCP Packer Bucket"
}
 
variable "vsphere_hcp_bucket_labels" {
  description = "Additional labels to apply to the bucket."
  type        = map(string)
  default = {
    "environment" = "dev"
  }
}
 
variable "vsphere_hcp_build_labels" {
  description = "Additional labels to apply to the build."
  type        = map(string)
  default = {
    "environment" = "dev"
  }
}
 
// vSphere Content Library
 
variable "vsphere_content_library_enabled" {
  description = "Enables the use of a vSphere content library."
  type        = bool
  default     = false
}
 
variable "vsphere_content_library" {
  description = "The vSphere content library to use."
  type        = string
  default     = "hcp-content-library"
}
 
variable "vsphere_content_library_ovf" {
  description = "Import as OVF template to the content library item."
  type        = bool
  default     = true
}
 
variable "vsphere_content_library_destroy" {
  description = "Destroy the virtual machine after the import to the content library."
  type        = bool
  default     = false
}
 
variable "vsphere_content_library_skip_export" {
  description = "Skip the import to the content library item. Useful during a build test stage."
  type        = bool
  default     = false
}
 
variable "vsphere_content_library_ovf_flags" {
  description = "Additional flags to pass to the OVF tool during the import process."
  type        = list(string)
  default     = []
}
 
// vSphere export
 
variable "vsphere_export_enabled" {
  description = "Enables the export of the image to OVF format."
  type        = bool
  default     = false
}
 
variable "vsphere_export_overwrite" {
  description = "Forces the export to overwrite existing files."
  type        = bool
  default     = true
}
 
variable "vsphere_export_format" {
  description = "The format of the exported image. Only ovf or ova supported."
  type        = string
  default     = "ovf"
}
 
variable "vsphere_ovf_export_path" {
  description = "Path to export the artifact."
  type        = string
  default     = "../../export"
}