module "app_nsg" {
  source = "../../modules/nsg"

  rg_name =  var.resource_group
  location  = var.location
  nsg_name  = "app-nsg"
  vnet_name = var.vnet_name
  subnet_id = module.vnet.app_subnet_id
  depends_on = [module.resource_group]

  nsg_rules =  [
    {
      name                       = "AllowHTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      port    = "80"
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
      port     = "443"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    }
  ]
}