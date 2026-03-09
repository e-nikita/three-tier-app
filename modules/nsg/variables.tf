variable "rg_name" {
    type = string
    description = "rg name" 
}

variable "vnet_name" {
    type = string
    description = "vnet name"
}

variable "nsg_name" {
    type = string
    description = "nsg name" 
}

variable "location" {
    type = string
    description = "Azure region"
}

variable "subnet_id" {
    type = string
    description = "subnet where nsg will attach"
}

variable "security_rules" {
    type = list(object({
      name = string
      priority = number
      port = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  
}