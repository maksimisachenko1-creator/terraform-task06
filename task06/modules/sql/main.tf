resource "random_password" "sql_admin" {
  length  = 16
  special = true
}

resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = "allow_azure_services"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_ip" {
  name             = "allow-verification-ip"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "this" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.this.id
  sku_name       = "S2"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 10
  zone_redundant = false
  tags           = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = "sql-admin-name"
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id
}

locals {
  fqdn = azurerm_mssql_server.this.fully_qualified_domain_name
}

