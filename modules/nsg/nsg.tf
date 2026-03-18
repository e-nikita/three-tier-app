# use this nsg config when create hardcoded nsg.

/*resource "azurerm_network_security_group" "myappnsg" {
    name = "app-nsg"
    resource_group_name = var.rg_name
    location = var.location 
}

resource "azurerm_network_security_group" "mydmznsg" {
    name = "dmz-nsg"
    resource_group_name = var.rg_name
    location = var.location 
}

resource "azurerm_network_security_group" "mydbnsg" {
    name = "db-nsg"
    resource_group_name = var.rg_name
    location = var.location
}*/

/*resource "azurerm_network_security_rule" "ports" {
    for_each                    = toset(var.allowed_ports)
    name                        = "allow-${each.value}"
    priority                    = 100 + each.key
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = each.value
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    
    resource_group_name = azurerm_resource_group.myrg.name
    network_security_group_name = azurerm_network_security_group.mydmznsg
  
}*/