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
    cnspec = {
      source  = "github.com/mondoohq/cnspec"
      version = ">= 10.0.0"
    }
  }
}