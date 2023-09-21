module "terraform_azurerm_neteng_vnet_dbx" {
  source = "git@github.com:dsg-tech/terraform-azurerm-neteng-vnet.git?ref=module-refactor"

  # Resource group to create the resources.
  resource_group_name = local.resource_group_name

  # Name the virtual network
  name = "datascaffold" # scaffold is an alt. to 'platform'... idk

  env = "np"

  # Location of the virtual network. This will also affect which transit network to peer with.
  location = "eastus"

  # Define the virtual network's IP range
  vnet_address_space = ["10.177.3.0/25"] #NOTE: we will not peer anything back in the build env, this is just for testing terraform

  # Define the DNS server IPs - Defaults to CSC. Use null for Azure dns.
  dns_servers = []

  # Define the subnets to create in the virtual network annd service endpoints
  # Possible value for service endpoints are: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, 
  # Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web
  subnets = {
    dbxpub = {
      # Define IP Ranges for Subnet
      address_prefixes  = ["10.177.3.0/26"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.Sql", "Microsoft.Web"]
      # Set to "true" if subnet would have private link
      enforce_private_link_endpoint_network_policies = false
      service_delegation_names                       = ["Microsoft.Databricks/workspaces"]
    },
    dbxnpub = {
      # Define IP Ranges for Subnet
      address_prefixes  = ["10.177.3.64/26"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.Sql", "Microsoft.Web"]
      # Set to "true" if subnet would have private link
      enforce_private_link_endpoint_network_policies = false
      service_delegation_names                       = ["Microsoft.Databricks/workspaces"]
    }
  }

  # Number of IPs to assign to the NAT Gateway. Creating an object with more than 1 ip will provide a contiguous IP Prefix. Multiple IP objects can be created and assigned to the NAT Gateway for scaling. The total of all IPs assigned to the NAT gateway cannot exceed 16. 
  # Updating an exisitng IP Prefix will destroy and recreate with different ranges. Options are 1,2,4,8,16.
  nat_ips = [
    # {
    #   name          = "eight_ip_prefix"
    #   number_of_ips = 8
    # },
    # {
    #   name          = "four_ip_prefix"
    #   number_of_ips = 4
    # },
    # {
    #   name          = "single_ip"
    #   number_of_ips = 1
    # },
    {
      name          = "single_ip_2"
      number_of_ips = 1
    }
  ]

  tags = {
    "group_owner"    = "${local.azure_ad_group}@dcsg.com"
    "DepartmentCode" = local.department_code
    "DepartmentName" = local.department_name
    "CostCenter"     = local.department_code
  }
}
output "dbx-vnet-outputs" {
  value = module.terraform_azurerm_neteng_vnet_dbx
}

module "platform_firewall_lookup" {
  source = "git@github.com:dsg-tech/tf-module-platform-firewall-lookup.git"

  firewall_tags = ["NP-PCF-PAS", "GITHUB-ACTIONS", "CLIENT-VPN"]
  source_region = "eastus"
}