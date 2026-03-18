resource "azurerm_application_gateway" "appgw" {
  name                = "term-point-appgw"
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
}

resource "azurerm_public_ip" "appgw_pip" {
  name                = "appgw-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}