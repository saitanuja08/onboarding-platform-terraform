data "databricks_user" "usr" {
  user_name = "me@example.com" # This is just a placeholder. Please update the value to an actual username before running the code.
}

resource "azurerm_resource_group" "dpaas" {
  name     = "DPaaS-workspace-rg"
  location = var.region
}

resource "azurerm_databricks_workspace" "dpaas" {
  name                        = "DPaaS-workspace"
  resource_group_name         = azurerm_resource_group.dpaas.name
  location                    = azurerm_resource_group.dpaas.location
  sku                         = "premium"
  tags = {
    Environment = var.tags
  }
}
resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "Shared Autoscaling"
  spark_version           = "11.2.x-cpu-ml-scala2.12"
  node_type_id            = "Standard_F4"
  autotermination_minutes = 20
}
resource "databricks_entitlements" "me" {
  user_id                    = data.databricks_user.me.id
  allow_cluster_create       = true
  allow_instance_pool_create = true
}


