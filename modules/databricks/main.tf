data "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
}

resource "azurerm_databricks_workspace" "dpaas" {
  name                        = var.databricks_workspace_name
  resource_group_name         = var.resource_group_name
  location                    = var.region
  sku                         = var.sku
  tags = {
    Environment = var.tags
  }
}
