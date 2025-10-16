output "sql_server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_connection_string" {
  value     = "Server=${azurerm_mssql_server.this.fully_qualified_domain_name};Database=${azurerm_mssql_database.this.name};User Id=${var.sql_admin_username};Password=${random_password.sql_admin.result};Trusted_Connection=False;Encrypt=True;"
  sensitive = true
}
