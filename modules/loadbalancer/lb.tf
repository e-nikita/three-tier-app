resource "azurerm_lb" "internal-lb" {
  name = var.internal_lb
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"

  frontend_ip_configuration {
    name = "frontend-ip-lb"
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.db_subnet_id
  }
}

#backend pool

resource "azurerm_lb_backend_address_pool" "db_backend" {
  name = "db-backend-pool"
  loadbalancer_id = azurerm_lb.internal-lb.id
  
}

# Health probe on port 1433 (SQL)

resource "azurerm_lb_probe" "sql_probe" {
  name            = "sql-probe"
  loadbalancer_id = azurerm_lb.internal-lb.id
  protocol        = "Tcp"
  port            = 1433 
}

# Load balancing rule
resource "azurerm_lb_rule" "sql_rule" {
  name                           = "sql-lb-rule"
  loadbalancer_id                = azurerm_lb.internal-lb.id
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = "frontend-ip-lb"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.db_backend.id]
  probe_id                       = azurerm_lb_probe.sql_probe.id
}

