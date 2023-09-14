vnet_name="poc-vnet"
public_subnet1_name="public-subnet-1"
public_subnet2_name="public-subnet-2"
private_subnet1_name="private-subnet-1"
private_subnet2_name="private-subnet-2"
route_table_name="public-rt"
vnet_cidr=["10.0.0.0/16"]
public_subnet1_cidr=["10.0.1.0/24"]
public_subnet2_cidr=["10.0.2.0/24"]
private_subnet1_cidr=["10.0.3.0/24"]
private_subnet2_cidr=["10.0.4.0/24"]
resource_group_name="onboarding-rg"
location="eastus"
azuread_users=["AD-User1", "AD-User2", "AD-User4", "AD-User5"]
log_analytics_workspace_name="poc-blob"
storage_account_name="poctanujstorageaccount"
storage_container_name="poc-log-analytics-workspace"
key_vault_name="poc-tan-key-vault"
key_vault_key_name="poc-kv-key"
key_permissions=["List", "Create", "Delete", "Get", "Purge", "Recover", "Update"]
secret_permissions=["List", "Delete", "Get", "Purge", "Recover"]
certificate_permissions=["List", "Create", "Delete", "Get", "Purge", "Recover", "Update"]
tenant_id="40f32e4e-08ac-49c5-b2fc-a71c2a4c2fbe"
object_id="acbe24ba-c58c-4ad5-ab1e-431ad2ea8af2"
key_type="RSA"
key_ops=["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
key_size="2048"
sp_display_name="GitHub Actions"