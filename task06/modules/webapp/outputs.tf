output "app_service_plan_id" {
  value = azurerm_app_service_plan.asp[0].id
}

output "app_hostname" {
  value = azurerm_linux_web_app.app[0].default_site_hostname
}
