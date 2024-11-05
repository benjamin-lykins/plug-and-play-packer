source "azure-arm" "windows" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = var.windows_version == 2022 ? "${var.windows_version}-datacenter-azure-edition" : "${var.windows_version}-datacenter-gensecond"
  os_type         = "Windows"

  //  Managed images and resource group - exported after build. Resource Group needs to exist prior to build.
  managed_image_name                = "windows-${var.windows_version}-${local.time}"
  managed_image_resource_group_name = "demo-packer-rg"

  vm_size = "Standard_DS1_v2"

  // While build the image, this resource group is utilized.
  location = "East US"


  // These are passed in the pipeline as GitHub Secrets.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id

  // WinRM Connection, this is recommended for Windows, SSH would be the recommendation for Linux distributions.
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "7m"
  winrm_use_ssl  = true
  winrm_username = "packer"
}
