module databricks {
  source 		    = "../../modules/databricks"
  region  		    = var.region
  sku 			    = var.sku
  databricks_workspace_name = var.databricks_workspace_name
  resource_group_name       = var.resource_group_name
  storage_account_name      = var.storage_account_name
  tags 			    = var.tags
}
