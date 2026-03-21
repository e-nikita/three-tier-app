resource "azurerm_public_ip" "appgwip" {
  name = "appgw-ip"
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Static"
  sku = "Standard"
  
}

resource "azurerm_application_gateway" "appgwtf" {
  name = "appgw-tf"
  resource_group_name = var.resource_group_name
  location = var.location

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgwip.id

  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name = "http-setting"
    cookie_based_affinity = "Disabled"
    port = 80
    protocol = "Http"
    request_timeout = 30

  }

  http_listener {
    name = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name = "frontend-port"
    protocol = "Http"
  }

  request_routing_rule {
    name = "routing-rule"
    rule_type = "Basic"
    http_listener_name = "http-listener"
    backend_address_pool_name = "backend-pool"
    priority = 100
  }
  
}