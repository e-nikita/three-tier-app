module "resource_group" {
  source = "../../modules/resource-group"
  resource_group_name = "myrgtf"
  location = "east us"
}

module "vnet" {
    source = "../../modules/vnet"
    vnet_name = "mytfvnet"
    resource_group_name = "myrgtf"
}