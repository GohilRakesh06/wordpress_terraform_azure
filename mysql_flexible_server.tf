resource "azurerm_mysql_flexible_server" "wp-flex-server" {
  name                   = var.flexible_server_name
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  administrator_login    = "wpadmin"
  administrator_password = "yourpassword"
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.wppublicSubnet2.id
    //private_dns_zone_id    = azurerm_private_dns_zone.mydnszone.id
  sku_name               = var.database_sku



  
  depends_on = [azurerm_resource_group.wordpressrg]
}

resource "azurerm_mysql_flexible_database" "wpdb" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = var.flexible_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on = [azurerm_resource_group.wordpressrg , azurerm_mysql_flexible_server.wp-flex-server]
}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_name
  server_name         = var.flexible_server_name
  value               = "OFF"
  depends_on = [azurerm_resource_group.wordpressrg , azurerm_mysql_flexible_server.wp-flex-server]
}

# resource "azurerm_private_dns_zone" "mydnszone" {
#   name                = "mydns.mysql.database.azure.com"
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
#   name                  = "mydnsVnetZone.com"
#   private_dns_zone_name = azurerm_private_dns_zone.mydnszone.name
#   virtual_network_id    = azurerm_virtual_network.wordpress_virtual_network.id
#   resource_group_name   = var.resource_group_name
# }
