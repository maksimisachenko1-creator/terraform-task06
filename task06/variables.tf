variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "name_prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "cmaz-ya42kk4d-mod6"
}

variable "existing_key_vault_resource_group" {
  description = "Resource group of an existing Key Vault to store SQL admin password"
  type        = string
  default     = "cmaz-ya42kk4d-mod6-kv-rg"
}

variable "existing_key_vault_name" {
  description = "Name of an existing Key Vault to store SQL admin password"
  type        = string
  default     = "cmaz-ya42kk4d-mod6-kv"
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
  default     = "cmaz-ya42kk4d-mod6-rg"
}

variable "sql_admin_username" {
  description = "SQL admin username"
  type        = string
  default     = "sqladmin"
}

variable "allowed_ip_address" {
  description = "IP address to allow through SQL firewall (verification agent). Update before verification."
  type        = string
  default     = "18.153.146.156"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = { Creator = "maksim_isachenko1@epam.com" }
}
