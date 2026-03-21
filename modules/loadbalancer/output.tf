output "internal_lb_ip" {
  value = azurerm_lb.internal-lb.frontend_ip_configuration[0].private_ip_address
}

output "db_backend_pool_id" {
  value = azurerm_lb_backend_address_pool.db_backend.id
}