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

data "azuread_client_config" "current" {}

# Create an Azure AD Group
resource "azuread_group" "grp" {
  display_name     = "poc-group"
  security_enabled = true
  prevent_duplicate_names = true
  assignable_to_role = true
  owners           = [data.azuread_client_config.current.object_id]
}

