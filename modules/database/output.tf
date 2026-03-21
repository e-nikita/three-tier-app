output "mssql_server" {
  value = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "mssql_db" {
  value = azurerm_mssql_database.db.name
}