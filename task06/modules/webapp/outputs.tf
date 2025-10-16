output "app_service_plan_id" {
  value = try(azurerm_service_plan.asp[0].id, var.app_service_plan_id)
}

output "app_hostname" {
  value = var.app_name != "" ? "${var.app_name}.azurewebsites.net" : ""
}
