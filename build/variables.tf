variable "login_approle_role_id" {
  description = "approle role id for logging into Vault"
  type        = string
  sensitive   = true
}
variable "login_approle_secret_id" {
  description = "approle secret id for logging into Vault"
  type        = string
  sensitive   = true
}
