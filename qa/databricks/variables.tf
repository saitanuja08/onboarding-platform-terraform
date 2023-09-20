variable "region" {
  type = string
}

variable "databricks_workspace_name" {
  description = "Name of the Databricks Workspace"
}

variable "sku" {
 type = string
}

variable "tags" {
 type = string
}

variable resource_group_name {
  description = "The name of the resource group"
  type = string
}

variable storage_account_name {
  description = "The name of the Route Table"
  type = string
}
