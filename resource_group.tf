terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.8.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.app_name}-${var.env}"
  location = var.location

  tags = {
    environment = var.env
  }
}
