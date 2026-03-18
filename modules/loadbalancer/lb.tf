resource "azurerm_lb" "internal_lb" {
  name                = "internal-lb"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
}

variable "rg_name" {
    type = string
}

variable "location" {
  type = string
}