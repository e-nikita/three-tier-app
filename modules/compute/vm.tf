resource "azurerm_linux_virtual_machine_scale_set" "app_vmss" {

  name                = "app-vmss"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard_DS1_v2"
  instances           = 2

  admin_username = "azureuser"
  admin_password = "Password123!"   # ⚠️ for testing only
  disable_password_authentication = false

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

}

variable "resource_group" {
    type = string  
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}