# Create the Resource Group
#resource azurerm_resource_group rg {
#  name                         = "poc-rg"
#  location                     = "eastus"
#}

# Create VNet
resource "azurerm_virtual_network" "poc_vnet" {
  name                = "poc-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "onboarding-rg"
}

# Create Private Subnet1
resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private-subnet-1"
  resource_group_name  = "onboarding-rg"
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create Private Subnet2
resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private-subnet-2"
  resource_group_name  = "onboarding-rg"
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}

# Create Public Subnet1
resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public-subnet-1"
  resource_group_name  = "onboarding-rg"
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Public Subnet2
resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public-subnet-2"
  resource_group_name  = "onboarding-rg"
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Route Table 
resource "azurerm_route_table" "public_route_table" {
  name                = "public-rt"
  location            = "eastus"
  resource_group_name = "onboarding-rg"

  route {
    name           = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

# Associate Route Table with Public Subnet1
resource "azurerm_subnet_route_table_association" "public_subnet_association_1" {
  subnet_id      = azurerm_subnet.public_subnet_1.id
  route_table_id = azurerm_route_table.public_route_table.id
}

# Associate Route Table with Public Subnet2
resource "azurerm_subnet_route_table_association" "public_subnet_association_2" {
  subnet_id      = azurerm_subnet.public_subnet_2.id
  route_table_id = azurerm_route_table.public_route_table.id
}

# Create an Azure AD Group
resource "azuread_group" "grp" {
  display_name     = "poc-group"
  security_enabled = true
}

resource "azuread_user" "usr" {
  for_each = toset(var.usernames)

  user_principal_name = "${each.value}@saitanuja0803gmail.onmicrosoft.com"
  display_name        = "${each.value} User"
  password            = "TempPassword123!"
  force_password_change = true

  depends_on = [ azuread_group.grp ]
}

resource "azuread_group_member" "usr" {
  for_each = azuread_user.usr

  group_object_id  = azuread_group.grp.id
  member_object_id = each.value.id
}

# Create the Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "la" {
  name                = "poc-log-analytics-workspace"
  location            = "eastus"
  resource_group_name = "onboarding-rg"
}

# Create the Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "poctanujstorageaccount"
  resource_group_name      = "onboarding-rg"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create the Blob Storage in the Storage Account
resource "azurerm_storage_container" "blob" {
  name                  = "poc-blob"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

# Enable the Diagnostic Settings for Storage Account
resource "azurerm_monitor_diagnostic_setting" "log-monitor" {
  name               = "poc-log-monitor"
  target_resource_id = azurerm_storage_account.sa.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id

  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

# Enable Diagnostic Settings at the Blob Level
resource "azurerm_monitor_diagnostic_setting" "blobmon" {
   name               = "poc-blob-storage"
   target_resource_id = "${azurerm_storage_account.sa.id}/blobServices/default"
   log_analytics_workspace_id = azurerm_log_analytics_workspace.la.id

   log {
    category = "StorageRead"
    enabled  = true
retention_policy {
      enabled = false
    }
   }

   log {
    category = "StorageWrite"
    enabled  = true
retention_policy {
      enabled = false
    }
   }

   log {
    category = "StorageDelete"
    enabled  = true
retention_policy {
      enabled = false
    }
   }
metric {
     category = "Transaction"
retention_policy {
       enabled = false
     }
   }
 }

# To upload a file into the Blob Storage
resource "azurerm_storage_blob" "upload" {
  name                   = "result.csv"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.blob.name
  type                   = "Block"
  source                 = "result.csv"
  depends_on = [ azurerm_storage_account.sa ]
}

# To store the sensitive information

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                       = "poc-key-vault"
  location                   = "eastus"
  resource_group_name        = "onboarding-rg"
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.object_id

    key_permissions    = var.key_permissions
    secret_permissions = var.secret_permissions
  }
}

resource "azurerm_key_vault_key" "key" {
  name = "poc-kv-key"

  key_vault_id = azurerm_key_vault.vault.id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_ops
}
