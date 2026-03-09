resource "azurerm_mssql_server" "sql" {
  name                         = "prod-sql-server"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
}

resource "azurerm_mssql_database" "db" {
  name      = "appdb"
  server_id = azurerm_mssql_server.sql.id
}