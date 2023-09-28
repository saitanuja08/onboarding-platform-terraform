variable vnet_name {
  description = "The name of the VNet"
  type = string
}

variable public_subnet1_name {
  description = "The name of the public subnet 1"
  type = string
}

variable public_subnet2_name {
  description = "The name of the public subnet 2"
  type = string
}

variable private_subnet1_name {
  description = "The name of the private subnet 1"
  type = string
}

variable private_subnet2_name {
  description = "The name of the private subnet 2"
  type = string
}

variable route_table_name {
  description = "The name of the Route Table"
  type = string
}

variable vnet_cidr {
  description = "The Address Space for the VNet"
  type = list
}

variable public_subnet1_cidr {
  description = "The Address Space for the Public Subnet 1"
  type = list
}

variable public_subnet2_cidr {
  description = "The Address Space for the Public Subnet 2"
  type = list
}

variable private_subnet1_cidr {
  description = "The Address Space for the Private Subnet 1"
  type = list
}

variable private_subnet2_cidr {
  description = "The Address Space for the Private Subnet 2"
  type = list
}

variable resource_group_name {
  description = "The name of the resource group"
  type = string
}

variable location {
  description = "The location in which the resources must be created"
  type = string
}

variable "azuread_users" {
  type    = list(string)
}

variable log_analytics_workspace_name {
  description = "The name of the Log Analytics Workspace"
  type = string
}

variable storage_account_name {
  description = "The name of the Route Table"
  type = string
}

variable storage_container_name {
  description = "The name of the Route Table"
  type = string
}

variable key_vault_name {
  description = "The name of the Key Vault"
  type = string
}

variable key_vault_key_name {
  description = "The name of the Key Vault Key"
  type = string
}

variable "sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
}

variable "certificate_permissions" {
  type        = list(string)
  description = "List of secret permissions."
}

variable "tenant_id" {
  type        = string
  description = "The Tenant Id"
}

variable "object_id" {
  type        = string
  description = "The Object Id"
}

variable "key_type" {
  description = "The JsonWebKeyType of the key to be created."
  type        = string
  validation {
    condition     = contains(["EC", "EC-HSM", "RSA", "RSA-HSM"], var.key_type)
    error_message = "The key_type must be one of the following: EC, EC-HSM, RSA, RSA-HSM."
  }
}

variable "key_ops" {
  type        = list(string)
  description = "The permitted JSON web key operations of the key to be created."
}

variable "key_size" {
  type        = number
  description = "The size in bits of the key to be created."
}

variable "sp_display_name" {
  type        = string
  description = "The Display Name of the Service Principal."
  default     = ""
}

variable "databricks_workspace_name" {
  description = "Name of the Databricks Workspace"
}

variable "sku" {
 type = string
}

variable "tags" {
 type = string
}
