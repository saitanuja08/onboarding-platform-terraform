data "azurerm_storage_account" "sa" {
  name                     = "poctanujstorageaccount"
  resource_group_name      = "onboarding-rg"
}

resource "azurerm_resource_group" "dpaas" {
  name     = var.databricks_resource_group
  location = var.region
}

resource "azurerm_databricks_workspace" "dpaas" {
  name                        = var.databricks_workspace_name
  resource_group_name         = azurerm_resource_group.dpaas.name
  location                    = var.region
  sku                         = var.sku
  tags = {
    Environment = var.tags
  }
}