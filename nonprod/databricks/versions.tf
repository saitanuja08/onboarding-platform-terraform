terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.65.0"
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

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.dpaas.id
  azure_tenant_id = "40f32e4e-08ac-49c5-b2fc-a71c2a4c2fbe"
  azure_client_id = "f89555ef-988a-4456-a2fc-af8a6e63d1e5"
  azure_client_secret = "Qrs8Q~PfDVbHuwxARoSk3u4-S29qSEX4a2vQwdy8"
}

provider "azurerm" {
  features {}
  subscription_id = "d0d1af53-8036-4e3e-b9e0-38a4df973cbb"
  azure_tenant_id = "40f32e4e-08ac-49c5-b2fc-a71c2a4c2fbe"
  azure_client_id = "f89555ef-988a-4456-a2fc-af8a6e63d1e5"
  azure_client_secret = "Qrs8Q~PfDVbHuwxARoSk3u4-S29qSEX4a2vQwdy8"
}
