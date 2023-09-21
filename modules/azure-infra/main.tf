
# Create the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create the Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create the Blob Storage Container in the Storage Account
resource "azurerm_storage_container" "blob" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

