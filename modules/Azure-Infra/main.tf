# Create the Resource Group
#resource azurerm_resource_group rg {
#  name                         = "poc-rg"
#  location                     = var.location
#}

# Create VNet
resource "azurerm_virtual_network" "poc_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create Private Subnet1
resource "azurerm_subnet" "private_subnet_1" {
  name                 = var.private_subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = var.private_subnet1_cidr
}

# Create Private Subnet2
resource "azurerm_subnet" "private_subnet_2" {
  name                 = var.private_subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = var.private_subnet2_cidr
}

# Create Public Subnet1
resource "azurerm_subnet" "public_subnet_1" {
  name                 = var.public_subnet1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = var.public_subnet1_cidr
}

# Create Public Subnet2
resource "azurerm_subnet" "public_subnet_2" {
  name                 = var.public_subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.poc_vnet.name
  address_prefixes     = var.public_subnet2_cidr
}

# Create Route Table 
resource "azurerm_route_table" "public_route_table" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

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
  prevent_duplicate_names = true
  assignable_to_role = true
}

<<<<<<< HEAD
=======
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
  name                       = "poc-tan-key-vault"
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

resource "azurerm_key_vault_access_policy" "terraform_sp_access" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore"
  ]

  secret_permissions = [
    "Get", "List", "Delete", "Recover", "Backup", "Restore", "Set"
  ]

  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "DeleteIssuers", "GetIssuers", "ListIssuers", "ManageContacts", "ManageIssuers", "SetIssuers"
  ]
}

resource "azurerm_key_vault_key" "key" {
  name = "poc-kv-key"

  key_vault_id = azurerm_key_vault.vault.id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_ops
}
>>>>>>> d4f253cb496ba2394680284e7d967838c4002471
