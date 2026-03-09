resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "app-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  instances           = 2
  sku                 = "Standard_B2s"
}

variable "resource_group_name" {
    type = string  
}