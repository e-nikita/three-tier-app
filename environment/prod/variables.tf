variable "resource_group" {
    type = string
    default = "myrgtf"

}

/*variable "allowed_ports" {
    default = ["80", "443", "8080"]
    type = number }*/

variable "location" {
  type = string
}
variable "vnetname" {
    type = string
}