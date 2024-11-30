source "vsphere-iso" "this" {
 
  vm_name       = "${var.vsphere_vm_name}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  guest_os_type = var.vsphere_guest_os_type
  shutdown_command         = var.vsphere_shutdown_command
  configuration_parameters = var.vsphere_configuration_parameters
 
  #Communicator
 
  /*
    Determines the communicator type based on the operating system type.
    If the OS type is "windows", the communicator is set to "winrm".
    Otherwise, it is set to "ssh".
 
    Sets the SSH password if the OS type is "linux".
    If the OS type is not "linux", the SSH password is set to null.
 
    Sets the SSH username if the OS type is "linux".
    If the OS type is not "linux", the SSH username is set to null.
 
    Sets the WinRM username if the OS type is "windows".
    If the OS type is not "windows", the WinRM username is set to null.
 
    Sets the WinRM password if the OS type is "windows".
    If the OS type is not "windows", the WinRM password is set to null.
  */
 
  communicator   = var.os_type == "windows" ? "winrm" : "ssh"
  ssh_password   = var.os_type == "linux" ? local.vsphere_ssh_password : null
  ssh_username   = var.os_type == "linux" ? "root" : null
  winrm_username = var.os_type == "windows" ? "administrator" : null
  winrm_password = var.os_type == "windows" ? local.vsphere_winrm_password : null
  winrm_insecure = var.os_type == "windows" ? var.vsphere_winrm_insecure : null
  winrm_use_ssl  = var.os_type == "windows" ? var.vsphere_winrm_use_ssl : null
  winrm_timeout  = var.os_type == "windows" ? "60m" : null
 
  #vSphere
  /*
    Configuration for connecting to a vSphere environment.
 
    Attributes:
    - vcenter_server: The address of the vCenter server.
    - username: The username for authenticating with the vCenter server.
    - password: The password for authenticating with the vCenter server.
    - datacenter: The name of the datacenter within vSphere.
    - cluster: The name of the cluster within the datacenter.
    - datastore: The name of the datastore to use.
    - folder: The name of the folder within the datacenter.
    - resource_pool: The name of the resource pool within the cluster.
  */
  vcenter_server = var.vsphere_vcenter_server
  username       = "ZSV16ZP"
  password       = local.vsphere_password
  datacenter    = var.vsphere_datacenter
  cluster       = var.vsphere_cluster
  datastore     = var.vsphere_datastore
  folder        = var.vsphere_folder
  resource_pool = var.vsphere_resource_pool
 
  #Removeables
 
  /*
    The following variables are used to specify the ISO details for the Packer build:
    -iso_checksum: The checksum of the ISO file to ensure its integrity.
    -iso_paths: The paths to the ISO files to be used in the Packer build.
    -iso_url: The url to the iso, will not run if iso_paths is not null.
  */
 
  iso_checksum = var.vsphere_iso_checksum
  iso_url      = var.vsphere_iso_url
  iso_paths    = var.vsphere_iso_paths
 
  floppy_dirs  = var.vsphere_floppy_dirs
  floppy_files = var.vsphere_floppy_files
 
 
  floppy_content = var.os_type == "windows" ? {
    "autounattend.xml" = templatefile("${path.cwd}/packer/shared/bootstrap/windows/autounattend.prktpl.hcl", {
      build_username       = "administrator"
      build_password       = local.vsphere_winrm_password
      vm_inst_os_eval      = false
      vm_inst_os_language  = "en-US"
      vm_inst_os_keyboard  = "en-US"
      vm_inst_os_image     = var.vm_inst_os_image
      vm_inst_os_key       = var.vm_inst_os_key
      vm_guest_os_language = "en-US"
      vm_guest_os_keyboard = "en-US"
      vm_guest_os_timezone = "UTC"
    }),
    "windows-vmtools.ps1" = file("${path.cwd}/packer/shared/scripts/windows/windows-vmtools.ps1"),
    "windows-init.ps1"    = file("${path.cwd}/packer/shared/scripts/windows/windows-init.ps1")
  } : null
 
 
 
  #Hardware
  /*
    Configuration for vSphere virtual machine resources.
 
    Attributes:
      CPUs (number): Number of CPUs allocated to the virtual machine.
      RAM (number): Amount of RAM (in MB) allocated to the virtual machine.
      firmware (string): Firmware type for the virtual machine.
     
    Network Adapters:
      network (string): Network to which the virtual machine is connected.
      network_card (string): Type of network card used by the virtual machine.
     
    Disk Controller:
      disk_controller_type (string): Type of disk controller used by the virtual machine.
     
    Storage:
      disk_size (number): Size of the disk (in GB) allocated to the virtual machine.
      disk_thin_provisioned (bool): Whether the disk is thin provisioned.
  */
  CPUs         = var.vsphere_cpus
  cpu_cores    = var.vsphere_cpu_cores
  CPU_hot_plug = var.vsphere_cpus_hotplug_enabled
 
  RAM          = var.vsphere_ram
  RAM_hot_plug = var.vsphere_ram_hotplug_enabled
  firmware     = var.vsphere_firmware
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vsphere_network_card
  }
  disk_controller_type = var.vsphere_disk_controller_type
  dynamic "storage" {
    for_each = var.vsphere_storage_config
    content {
      disk_size             = storage.value.disk_size
      disk_thin_provisioned = storage.value.disk_thin_provisioned
    }
  }
 
  #Boot
  // Specifies the HTTP directory for the vSphere build process.
  // This directory contains the necessary files for the HTTP server to serve during the build process.
  http_directory = var.vsphere_http_directory
 
  // Defines the boot command sequence for the vSphere virtual machine.
  // This command sequence is used to automate the initial boot process of the VM.
  boot_command = var.vsphere_boot_command
 
  // Sets the wait time after the VM boots before proceeding with the next step in the build process.
  // This is useful to ensure that the VM is fully initialized before continuing.
  boot_wait = var.vsphere_boot_wait
 
  #Post Processing
  remove_cdrom = var.vsphere_remove_cdrom
 
  // Template and Content Library Settings
  convert_to_template = var.vsphere_convert_to_template
  /*
    This block dynamically creates a `content_library_destination` configuration
    if the `vsphere_content_library_enabled` variable is set to true. The `for_each`
    statement ensures that the block is only created when the condition is met.
 
    The `content` block within `content_library_destination` includes the following attributes:
    - `library`: Specifies the vSphere content library to use, defined by the `vsphere_content_library` variable.
    - `ovf`: Import an OVF template to the content library item. (bool)
    - `destroy`:  Destroy the virtual machine after the import to the content library. (bool)
    - `skip_import`: Skip the import to the content library item. Useful during a build test stage. (bool)
    - `ovf_flags`: Additional flags to pass to the OVF tool during the import process. ([]string)
  */
 
  dynamic "content_library_destination" {
    for_each = var.vsphere_content_library_enabled ? [1] : []
    content {
      library     = var.vsphere_content_library
      ovf         = var.vsphere_content_library_ovf
      destroy     = var.vsphere_content_library_destroy
      skip_import = var.vsphere_content_library_skip_export
      ovf_flags   = var.vsphere_content_library_ovf ? var.vsphere_content_library_ovf_flags : null
    }
  }
 
  // OVF Export Settings
  /*
    This block dynamically creates an "export" block based on the value of `var.vsphere_export_enabled`.
    If `var.vsphere_export_enabled` is true, the "export" block is created with the following properties:
   
    - `name`: The name of the exported image in Open Virtualization Format (OVF).
    - `force`:  Forces the export to overwrite existing files.
    - `options`: Advanced image export options.
    - `output_format`: The format of the exported image. Only ovf or ova supported.
    - `output_directory`: Set to the value of `vsphere_ovf_export_pathh`.
   
    If `var.vsphere_export_enabled` is false, the "export" block is not created.
  */
  dynamic "export" {
    for_each = var.vsphere_export_enabled ? [1] : []
    content {
      name          = var.vsphere_vm_name
      force         = var.vsphere_export_overwrite
      output_format = var.vsphere_export_format
      options = [
        "extraconfig" #Extra configuration options are exported for the virtual machine.
      ]
      output_directory = "${var.vsphere_ovf_export_path}/${var.jenkins_build_tag}"
    }
  }
}
