terraform {
  cloud {
    organization = "lykins-demo-org"

    workspaces {
      name = "packer-azure"
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}

variable "client_secret" {
  type = string
}

provider "azurerm" {
  features {}
  client_id       = "a7f2a9cc-2bd5-43f5-bf7e-fa244b298316"
  client_secret   = var.client_secret
  tenant_id       = "ab2e4aa2-3855-48b9-8d02-619cee6d9513"
  subscription_id = "16d750eb-6d45-404c-a06a-a507a663be9e"
}

module "windows" {
  source  = "Azure/virtual-machine/azurerm"
  version = "1.1.0"

  name                = "ben-win-vm"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  size                = "Standard_DS1_v2"
  image_os            = "windows"
  source_image_id     = "/subscriptions/16d750eb-6d45-404c-a06a-a507a663be9e/resourceGroups/demo-packer-rg/providers/Microsoft.Compute/images/windows-2019-20240513150258-secure"
  subnet_id           = azurerm_subnet.this.id

  admin_password = sensitive(random_password.this.result)

  os_disk = {
    name                 = "ben-wim-vm-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}


resource "random_password" "this" {
  length = 24
}

resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  name                = "ben-vnet"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "ben-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

resource "azurerm_resource_group" "this" {
  name     = "tf-packer-demo-rg"
  location = "eastus"
}
