packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }

  }
}