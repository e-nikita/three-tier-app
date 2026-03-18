terraform {
  backend "azurerm" {
    storage_account_name = "pbackendstgaccount"
    container_name = "tf-backup"
    resource_group_name = "rgstg1"
    key = "prod.terraform.tfstate"
    
  }
}