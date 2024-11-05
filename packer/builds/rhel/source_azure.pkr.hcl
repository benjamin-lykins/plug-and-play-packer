
source "azure-arm" "rhel" {

  // Grab the latest version of the Windows Server 2019 Datacenter
  image_publisher = "redhat"
  image_offer     = "RHEL"
  image_sku       = "9${var.rhel_minor_version}-gen2"

  //  Managed images and resource group.
  managed_image_name                = "rhel-9-3-${local.time}"
  managed_image_resource_group_name = "demo-packer-rg"

  // While building the image, this resource group is utilized.
  build_resource_group_name = "demo-packer-builds-rg"

  // OS 
  vm_size = "Standard_DS1_v2"
  os_type = "linux"

  // These are passed in the pipeline.

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}