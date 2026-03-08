terraform {
  backend "azurerm" {
    storage_account_name = "prod-backendstgtfaccount"
    container_name = "tf-backup"
    resource_group_name = "myrgtf"
    key = "prod.terraform.tfstate"
    
  }
}