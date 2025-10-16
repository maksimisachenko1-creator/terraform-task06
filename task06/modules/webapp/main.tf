resource "azurerm_app_service_plan" "asp" {
  count               = var.create_only_plan ? 1 : (var.app_service_plan_id == "" ? 1 : 0)
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  sku {
    tier = "PremiumV3"
    size = var.sku_name
  }
  tags = var.tags
}

resource "azurerm_linux_web_app" "app" {
  count               = var.create_only_plan ? 0 : 1
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  # Use provided app service plan id when available, otherwise use the created plan
  server_farm_id = var.app_service_plan_id != "" ? var.app_service_plan_id : azurerm_app_service_plan.asp[0].id

  site_config {
    dotnet_framework_version = "v${var.dotnet_version}"
    linux_fx_version         = "DOTNETCORE|${var.dotnet_version}"
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

output "app_service_plan_id" {
  value = coalesce(try(azurerm_app_service_plan.asp[0].id, null), var.app_service_plan_id)
}

output "app_hostname" {
  value = azurerm_linux_web_app.app[0].default_site_hostname
}
