variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "asp_name" {
  type = string
}

variable "sku_name" {
  type = string
  default = "P0v3"
}

variable "dotnet_version" {
  type = string
  default = "8.0"
}

variable "sql_connection_string" {
  type      = string
  sensitive = true
}

variable "create_only_plan" {
  type    = bool
  default = false
}

variable "app_service_plan_id" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
}
