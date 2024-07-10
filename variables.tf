variable "resource_group_name" {
    default = "wordpress_rg"
}

variable "resource_group_location" {
    default = "Central India"
}
variable "virtual_network_name" {
  default = "wordpress-network"
}

variable "nic" {
    default = "wordpress-nic"
  
}

variable "wordpressvm_public_ip" {
  default = "wordpressvm_public_ip"
}

variable "linux_virtual_machine_name" {
    default = "wordpress-virtual-machine"
  
}

variable "size_vm" {
    default = "Standard_D2s_v3"
  
}

variable "vm_username" {
  default = "wordpressuser"
}

variable "vm_publisher" {
  default = "RedHat"
}

variable "vm_offer" {
  default = "RHEL"
}

variable "vm_sku" {
  default = "9_3"
}

variable "vm_version" {
    default = "latest"
}

variable "vnet_gateway_name" {
  default ="wordpress_virtual_network_gateway"
}

variable "route_table_name" {
  default = "wordpress-route-table"
}

variable "database_sku" {
  default = "GP_Standard_D2ds_v4"
}

variable "database_name" {
    default = "wpdb"
  
}
variable "flexible_server_name" {
  default = "wpdbrakeshserver"
}