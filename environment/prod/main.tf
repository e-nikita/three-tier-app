module "resource_group" {
  source = "../../modules/resource_group"
  resource_group_name = var.resource_group
  location = var.location
}

module "vnet" {
    source = "../../modules/vnet"
    vnet_name = var.vnet_name
    resource_group_name = var.resource_group
    location = var.location
    depends_on = [module.resource_group]
}

module "compute" {
    source = "../../modules/compute"
    resource_group = var.resource_group
    location = var.location
    subnet_id = module.vnet.app_subnet_id 
    depends_on = [module.vnet, module.app_nsg, module.database, module.appgateway]
    backend_pool_id = module.appgateway.backend_pool_id

    db_host     =  module.loadbalancer.internal_lb_ip
    db_name     = module.database.mssql_db
    db_username = var.sql_admin_username
    db_password = data.azurerm_key_vault_secret.db_password.value

}

module "database" {
    source = "../../modules/database"
    resource_group_name = var.resource_group
    location = "centralindia"
    sql_server_name = var.sql_server_name
    sql_admin_username = var.sql_admin_username
    sql_admin_password = data.azurerm_key_vault_secret.db_password.value
    depends_on = [module.resource_group]
  
}

module "appgateway" {
    source = "../../modules/appgateway"
    resource_group_name = var.resource_group
    location = var.location
    subnet_id = module.vnet.appgw_subnet
    depends_on = [ module.vnet ]
  
}

module "loadbalancer" {
  source              = "../../modules/loadbalancer"
  internal_lb =  var.internal_lb
  resource_group_name = var.resource_group
  location            = var.location
  db_subnet_id        = module.vnet.db_subnet_id
  depends_on          = [module.vnet]
}

