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

provider "azurerm" {
  features {}
}

module "windows" {
  source  = "Azure/virtual-machine/azurerm"
  version = "1.1.0"

  name                = "ben-win-vm"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  size                = "Standard_DS1_v2"
  image_os            = "windows"
  source_image_id     = "value"
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
  name     = "ben-rg"
  location = "eastus"
}
