locals {
  default_policy = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    },
    "custom_tags.Team" : {
      "type" : "fixed",
      "value" : var.team
    }
  }
}

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

resource "databricks_cluster_policy" "fair_use" {
  name       = "${var.team} cluster policy"
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))
}

resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.fair_use.id
  access_control {
    group_name       = var.team
    permission_level = "CAN_USE"
  }
}


