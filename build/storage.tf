resource "azurerm_log_analytics_workspace" "storage_log_analytics" {
  name                = "storage-la-build-test"
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "storage_account_dataplatform_build" {
  source = "git@github.com:dsg-tech/tf-module-azure-storageaccount.git?ref=v1.0.0"

  resource_group_name = local.resource_group_name
  # The storage account name should start with 'stdsg'. 
  # Storage account names must be between 3 and 24 characters in length.
  # May contain numbers and lowercase letters only and must be globally unique.
  name = "stdsgdataplatform${local.environment_prefix}"
  # The path in the vault to store secrets generated for the storage account.
  # Includes the primary_blob_endpoint and primary/secondary access keys.
  vault_secret_path = "concourse/${local.vault_team_name}/azure/storage-account/stdsgdataplatform${local.environment_prefix}"
  # Region the storage account should be created in
  location = "eastus"
  # Defines the type of replication to use for this storage account. Valid
  # options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS 
  account_replication_type = "LRS"
  # Defines the Tier to use for this storage account. Valid options are Standard
  # and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. 
  account_tier = "Standard"
  # Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts.
  # Valid options are Hot and Cool
  access_tier = "Hot"

  # Defines the Kind of account. Valid options are BlobStorage,
  # BlockBlobStorage, FileStorage, Storage and StorageV2 
  account_kind = "StorageV2"


  azurerm_log_analytics_workspace_name = azurerm_log_analytics_workspace.storage_log_analytics.name

  # Resource group name of the log analytics workspace. 
  # If you do not have a log analytics workspace resource name, you may specify "platform-tools". 
  azurerm_log_analytics_workspace_resource_group_name = local.resource_group_name
  # Enables versioned blobs to automatically maintain previous versions of your
  # blobs for recovery and restoration.
  is_hns_enabled             = true
  versioning_enabled         = false
  soft_delete_retention_days = 0

  firewall_tags = ["NP-PCF-PAS", "GITHUB-ACTIONS", "CLIENT-VPN"]

  # List of additional ip ranges to allow access from - for most use cases,
  # please use the firewall_tags section above.
  ip_range_filter = ["199.30.192.0/22"]

  # List of subnet IDs to be added to the firewall VNET rules in addition to firewall_tags 
  firewall_subnet_ids = concat(module.platform_firewall_lookup.subnet_ids,
    ["/subscriptions/d13e15e9-ec20-4cea-b738-e68fd568be32/resourceGroups/rg-dataplatformbuild-np/providers/Microsoft.Network/virtualNetworks/vnet-np-sub-data-analytics-nonprod-1-eastus-datascaffold/subnets/snet-np-datascaffold-dbxpub",
  "/subscriptions/d13e15e9-ec20-4cea-b738-e68fd568be32/resourceGroups/rg-dataplatformbuild-np/providers/Microsoft.Network/virtualNetworks/vnet-np-sub-data-analytics-nonprod-1-eastus-datascaffold/subnets/snet-np-datascaffold-dbxnpub"])
  tags = {
    "group_owner"    = "${local.azure_ad_group}@dcsg.com"
    "DepartmentCode" = local.department_code
    "DepartmentName" = local.department_name
    "CostCenter"     = local.department_code
  }
  depends_on = [
    module.terraform_azurerm_neteng_vnet_dbx
  ]

}

resource "azurerm_storage_data_lake_gen2_filesystem" "storage_container_control_plane" {
  name               = "control-plane-${local.environment_prefix}"
  storage_account_id = module.storage_account_dataplatform_build.id
  ace {
    type        = "user"
    id          = "4646f331-bef9-477e-9830-7219c90a90e3" # G_PCF_DataOps_Developers
    permissions = "rwx"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "storage_container_datalake" {
  name               = "datalake-${local.environment_prefix}"
  storage_account_id = module.storage_account_dataplatform_build.id
  ace {
    type        = "user"
    id          = "4646f331-bef9-477e-9830-7219c90a90e3"
    permissions = "rwx"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "storage_container_gcp_landing_zone" {
  name               = "gcplandingzone-${local.environment_prefix}"
  storage_account_id = module.storage_account_dataplatform_build.id
  ace {
    type        = "user"
    id          = "4646f331-bef9-477e-9830-7219c90a90e3"
    permissions = "rwx"
  }
}