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

#data "azuread_client_config" "current" {}

# Create an Azure AD Group
#resource "azuread_group" "grp" {
#  display_name     = "poc-group"
#  security_enabled = true
#  prevent_duplicate_names = true
#  assignable_to_role = true
#  owners           = [data.azuread_client_config.current.object_id]
#}

#resource "azuread_user" "usr" {
#  for_each = toset(var.azuread_users)

#  user_principal_name = "${each.value}@saitanuja0803gmail.onmicrosoft.com"
#  display_name        = "${each.value} User"
#  password            = "TempPassword123!"
#  force_password_change = true

#  depends_on = [ azuread_group.grp ]
#}

# Create the Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "la" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create the Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create the Blob Storage in the Storage Account
resource "azurerm_storage_container" "blob" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

# Create Key Vault
resource "azurerm_key_vault" "vault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
}

# Create Key Vault Policy
resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = var.key_permissions  
  secret_permissions = var.secret_permissions
  certificate_permissions = var.certificate_permissions

}

data "azuread_service_principal" "sp" {
  display_name = var.sp_display_name
}

# Create Key Vault Access Policy for the Service Principal
resource "azurerm_key_vault_access_policy" "sp" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = data.azuread_service_principal.sp.object_id

  key_permissions = var.key_permissions  
  secret_permissions = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}
