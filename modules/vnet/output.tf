output "dmz_subnet_id" {
  value = azurerm_subnet.dmzsubnet.id
}

output "app_subnet_id" {
  value = azurerm_subnet.appsubnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.dbsubnet.id
}