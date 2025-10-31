terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {
    resource_group_name  = "dmnlaabs-terraform-rg"
    storage_account_name  = "dmnlaabstfstate"
    container_name        = "tfstate"
    key                   = "dev.terraform.tfstate"
  }
}