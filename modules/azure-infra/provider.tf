terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.5.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}
