module "app_nsg" {
  source = "../../modules/nsg"

  rg_name =  var.resource_group
  location  = var.location
  nsg_name  = "app-nsg"
  vnet_name = var.vnetname
  subnet_id = module.vnet.app_subnet_id

  security_rules = [
    {
      name                       = "AllowHTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTPS"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    }
  ]
}