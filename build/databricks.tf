module "databricks_test_build" {
  source = "git@github.com:dsg-tech/tf-module-azure-databricks-jpr.git?"

  # All possible inputs listed here and explained with a description
  # Default/Optional vars should be commented out with only required vars uncommented.

  # The name of the resource group in which to create the Azure Databricks Workspace . Changing this forces a new resource to be created.
  resource_group_name = local.resource_group_name


  # The  workspace name must only contain lowercase letters, numbers, and hyphens.
  # The workspace name must not start or end in a hyphen.
  name = "databricks-test-build"

  # The Pricing tier of the Azure Databricks workspace . https://www.databricks.com/product/azure-pricing
  # The name of the SKU, Standar or Premium.

  sku_name = "premium"

  location = local.resource_group_location

  virtual_network_name = "vnet-np-sub-data-analytics-nonprod-1-eastus-datascaffold"

  vnet_resource_group_name = local.resource_group_name

  private_nsg_name = "nsg-np-eastus-datascaffold-dbxnpub"
  public_nsg_name  = "nsg-np-eastus-datascaffold-dbxpub"

  # Delegated subnet ID. Azure Databrick runs in delegated subnet network.

  subnet_private_name = "snet-np-datascaffold-dbxnpub"

  subnet_public_name = "snet-np-datascaffold-dbxpub"



  # Name of the log analytics workspace. Azure Databricks workspace will send logs and metrics to log analytics workspace.
  # If you do not have a log analytics workspace, you may specify "azure-logs-dev" for nonprod and "azure-logs-prod" for prod environment. 
  # azurerm_log_analytics_workspace_name = "<name-of-the-log-analytics_workspace>"

  # Resource group name of the log analytics workspace. 
  # If you do not have a log analytics workspace resource name, you may specify "platform-tools". 
  # azurerm_log_analytics_workspace_resource_group_name = "<log-analytics-resource-group-name>"

  # Map of custom tags to add to the deployed resources - group_owner and CostCenter must be specified.
  tags = {
    "group_owner" = local.department_name
    "CostCenter"  = local.department_code
  }
}