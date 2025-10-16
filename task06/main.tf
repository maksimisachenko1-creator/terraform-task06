provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault" "existing" {
  name                = var.existing_key_vault_name
  resource_group_name = var.existing_key_vault_resource_group
}

module "sql" {
  source = "./modules/sql"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sql_server_name     = local.sql_server_name
  sql_db_name         = local.sql_db_name
  sql_admin_username  = var.sql_admin_username
  key_vault_id        = data.azurerm_key_vault.existing.id
  allowed_ip_address  = var.allowed_ip_address
  tags                = var.tags
}

module "webapp" {
  source = "./modules/webapp"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = module.webapp_plan.app_service_plan_id
  app_name            = local.app_name
  asp_name            = local.asp_name
  dotnet_version      = "8.0"
  sql_connection_string = module.sql.sql_connection_string
  tags                = var.tags
}

/* Create App Service Plan using a small child module under webapp for clarity */
module "webapp_plan" {
  source = "./modules/webapp"
  create_only_plan = true

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  asp_name            = local.asp_name
  sku_name            = "P0v3"
  tags                = var.tags
}
