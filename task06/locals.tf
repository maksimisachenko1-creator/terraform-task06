locals {
  rg_name         = var.rg_name
  sql_server_name = "${var.name_prefix}-sql"
  sql_db_name     = "${var.name_prefix}-sql-db"
  asp_name        = "${var.name_prefix}-asp"
  app_name        = "${var.name_prefix}-app"
}
