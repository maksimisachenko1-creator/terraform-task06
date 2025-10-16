resource "azurerm_service_plan" "asp" {
  count               = var.create_only_plan ? 1 : 0
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  count               = var.create_only_plan || var.app_name == "" ? 0 : 1
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  # Use provided app service plan id when available, otherwise use the created plan
  service_plan_id = var.app_service_plan_id != "" ? var.app_service_plan_id : try(azurerm_service_plan.asp[0].id, "")

  site_config {
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  dynamic "connection_string" {
    for_each = var.sql_connection_string != "" ? [1] : []
    content {
      name  = "DefaultConnection"
      type  = "SQLAzure"
      value = var.sql_connection_string
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
