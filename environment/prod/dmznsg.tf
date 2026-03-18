module "dmz_nsg" {
  source = "../../modules/nsg"

  rg_name   = var.resource_group
  location  = var.location
  nsg_name  = "dmz-nsg"
  vnet_name = var.vnet_name
  subnet_id = module.vnet.dmz_subnet_id
  depends_on = [module.resource_group]

  nsg_rules = [
    {
      name                       = "AllowHTTPS"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      port    = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    }
  ]
}