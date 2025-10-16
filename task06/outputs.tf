output "sql_server_fqdn" {
  description = "Fully qualified domain name for SQL Server"
  value       = module.sql.sql_server_fqdn
}

output "app_hostname" {
  description = "Linux Web App hostname"
  value       = module.webapp.app_hostname
}
