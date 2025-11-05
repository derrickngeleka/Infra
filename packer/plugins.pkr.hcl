packer {
  required_version = ">= 1.10.0"
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2.5"
    }
  }
}
