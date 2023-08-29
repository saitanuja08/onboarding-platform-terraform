output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.dpaas.workspace_url}/"
}
