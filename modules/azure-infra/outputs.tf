output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.databricks_workspace.workspace_url}/"
}
