terraform {
  required_version = ">=0.15.1"
  required_providers {
    azurerm = {
      version = ">= 3 , < 4 "
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-dataplatform-np"
    storage_account_name = "stdsgdataplatforminfra"
    container_name       = "build"
    key                  = "dataplatform-build-env.tfstate"
  }
}


locals {
  environment_prefix                  = "build"
  environment                         = "build"
  subscription_id                     = "d13e15e9-ec20-4cea-b738-e68fd568be32"
  resource_group_name                 = "rg-dataplatformbuild-np"
  resource_group_location             = "East US"
  azure_ad_group                      = "g_pcf_dataops_developers"
  department_code                     = "96856"
  department_name                     = "dataops"
  github_owner                        = "dsg-tech"
  github_account                      = "srv-dataops-dev"
  data_factory_repository_target_path = "/"
  data_factory_storage_account        = "stdsgdataops"
  vault_team_name                     = "dataops"
}