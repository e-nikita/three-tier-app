variable "resource_group" {
    type = string
    default = "myrgtf"

}

/*variable "allowed_ports" {
    default = ["80", "443", "8080"]
    type = number }*/

variable "location" {
  type = string
  default = "westeurope"
}
variable "vnet_name" {
    type = string
    default = "myvnettf"
}

variable "sql_server_name" {
  type = string
  default = "prodsql-servernik1"
}

variable "sql_admin_username" {
  type = string
  default = "dbusername"
}

variable "sql_admin_password" {
  type = string
  default = "password@123"
}