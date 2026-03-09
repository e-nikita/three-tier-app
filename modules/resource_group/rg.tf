resource "azurerm_resource_group" "myrg" {
    name = var.resource_group_name
    location = var.location 
}

variable "resource_group_name" {
  type = string
  description = "resource group name"
}

variable "location" {
  type = string
}