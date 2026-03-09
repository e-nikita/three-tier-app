module "resource_group" {
  source = "../../modules/resource_group"
  resource_group_name = "myrgtf"
  location = "east us"
}

module "vnet" {
    source = "../../modules/vnet"
    vnet_name = "mytfvnet"
    resource_group_name = "myrgtf"
}

module "compute" {
    source = "../../modules/compute"
    resource_group_name = "myrgtf"

}

module "database" {
    source = "../../modules/database"
    resource_group_name = "myrgtf"
  
}

