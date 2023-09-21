resource "azurerm_key_vault" "dataops-kv" {
  name                        = "kv-dops-build"
  location                    = data.azurerm_resource_group.rm.location
  resource_group_name         = data.azurerm_resource_group.rm.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "56eaf8aa-4a3a-4be4-89db-8a247b02ab74"

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "4646f331-bef9-477e-9830-7219c90a90e3"

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Backup", "Restore", "Purge", "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = module.platform_firewall_lookup.ip_ranges
    virtual_network_subnet_ids = concat(module.platform_firewall_lookup.subnet_ids, ["/subscriptions/d13e15e9-ec20-4cea-b738-e68fd568be32/resourceGroups/rg-dataplatformbuild-np/providers/Microsoft.Network/virtualNetworks/vnet-np-sub-data-analytics-nonprod-1-eastus-datascaffold/subnets/snet-np-datascaffold-dbxpub",
    "/subscriptions/d13e15e9-ec20-4cea-b738-e68fd568be32/resourceGroups/rg-dataplatformbuild-np/providers/Microsoft.Network/virtualNetworks/vnet-np-sub-data-analytics-nonprod-1-eastus-datascaffold/subnets/snet-np-datascaffold-dbxnpub"])
  }

  depends_on = [
    module.terraform_azurerm_neteng_vnet_dbx
  ]
}