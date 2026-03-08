resource "azurerm_virtual_network" "myvnet" {
    name = var.virtual_network
    resource_group_name = var.resource_group_name
    location = azurerm_resource_group.myrg.location
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "dmzsubnet" {
    name = "dmzsubnet"
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = ["10.0.1.0/24"]
    resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet" "appsubnet" {
    name = "appsubnet"
    virtual_network_name = azurerm_virtual_network.myvnet.name
    resource_group_name = azurerm_resource_group.myrg.name
    address_prefixes = ["10.0.2.0/24"]    
}

resource "azurerm_subnet" "dbsubnet" {
    name = "dbsubnet"
    virtual_network_name = azurerm_virtual_network.myvnet.name
    resource_group_name = azurerm_resource_group.myrg.name
    address_prefixes = ["10.0.3.0/24"]
  
}
