packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    cnspec = {
      source  = "github.com/mondoohq/cnspec"
      version = ">= 10.0.0"
    }
  }
}