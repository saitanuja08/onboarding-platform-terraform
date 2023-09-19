module databricks {
  source 		    = "../../modules/databricks"
  region  		    = var.region
  sku 			    = var.sku
  databricks_workspace_name = var.databricks_workspace_name
  databricks_resource_group = var.databricks_resource_group
  tags 			    = var.tags
}
