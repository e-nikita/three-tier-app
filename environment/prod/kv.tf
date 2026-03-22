data "azurerm_key_vault" "kv" {
    name = "testkvhim"
    resource_group_name = "rg-eeshumishra-6462"
}

data "azurerm_key_vault_secret" "db_password" {
    name = "sql-admin-password"
    key_vault_id = data.azurerm_key_vault.kv.id
  
}
