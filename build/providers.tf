provider "azurerm" {
  subscription_id = "d13e15e9-ec20-4cea-b738-e68fd568be32"
  features {}
}

provider "azuread" {
}


provider "vault" {
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }

  address = "https://vault.tools.dcsg.com"
}