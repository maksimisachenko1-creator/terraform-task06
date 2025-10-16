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
  type    = string
  default = "cmaz-ya42kk4d-mod6-kv-rg"
}

variable "existing_key_vault_name" {
  type    = string
  default = "cmaz-ya42kk4d-mod6-kv"
}

variable "rg_name" {
  type    = string
  default = "cmaz-ya42kk4d-mod6-rg"
}

variable "sql_admin_username" {
  type    = string
  default = "sqladmin"
}

variable "allowed_ip_address" {
  description = "IP address to allow through SQL firewall (verification agent). Update before verification."
  type        = string
  default     = "18.153.146.156"
}

variable "tags" {
  type = map(string)
  default = { Creator = "maksim_isachenko1@epam.com" }
}
