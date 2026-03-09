resource "azurerm_application_gateway" "myappgateway" {
    name = var.application_gateway
    resource_group_name = azurerm_resource_group.myrg.container_name
    location = azurerm_resource_group.myrg.location
}