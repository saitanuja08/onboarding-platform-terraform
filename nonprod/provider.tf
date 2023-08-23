

terraform {
  required_providers {
  azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.65.0"
    }
  databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}
