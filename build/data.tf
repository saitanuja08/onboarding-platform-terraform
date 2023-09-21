# Configure the Microsoft Azure Provider
data "azurerm_client_config" "current" {}


data "azurerm_resource_group" "rm" {
  name = local.resource_group_name
}