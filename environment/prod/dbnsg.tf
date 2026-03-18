module "db_nsg" {
  source = "../../modules/nsg"

  rg_name   = var.resource_group
  location  = var.location
  nsg_name  = "db-nsg"
  subnet_id = module.vnet.db_subnet_id
  vnet_name = var.vnet_name
  depends_on = [module.resource_group]

  nsg_rules = [
    {
      name                       = "AllowSQL"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      port     = "1433"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "*"
    }
  ]
}