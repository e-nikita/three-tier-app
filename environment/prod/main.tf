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
    depends_on = [module.vnet, module.app_nsg]

}

module "database" {
    source = "../../modules/database"
    resource_group_name = var.resource_group
    location = "centralindia"
    sql_server_name = var.sql_server_name
    sql_admin_username = var.sql_admin_username
    sql_admin_password = var.sql_admin_password
    depends_on = [module.resource_group]
  
}

