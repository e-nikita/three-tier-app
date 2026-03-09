resource "azurerm_network_security_group" "nsg" {
    name = var.nsg_name
    location = var.location
    resource_group_name = var.rg_name
  
}

resource "azurerm_network_security_rule" "rules" {
    network_security_group_name = azurerm_network_security_group.nsg.name
    resource_group_name = var.rg_name
    for_each = { for rule in var.security_rules : rule.name => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
    subnet_id = var.subnet_id
    network_security_group_id = azurerm_network_security_group.nsg.id
}
