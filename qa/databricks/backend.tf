terraform {
  backend "azurerm" {
    resource_group_name  = "onboarding-rg"
    storage_account_name = "onboardingtfstatefiles"
    container_name       = "tfstate"
    key                  = "nonprod.databricks.terraform.tfstate"
  }
}

