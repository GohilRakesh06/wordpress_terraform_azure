

resource "azurerm_route_table" "wp_route_table" {
  name                          = var.route_table_name
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
  depends_on = [ azurerm_resource_group.wordpressrg ]

  route {
    name           = "internetroute1"
    address_prefix = "0.0.0.0/16"
    next_hop_type  = "Internet"
  }

 
}

resource "azurerm_subnet_route_table_association" "wp_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.wppublicSubnet1.id
  route_table_id = azurerm_route_table.wp_route_table.id
}

resource "azurerm_subnet_route_table_association" "wp_subnet_route_table_association_2" {
  subnet_id      = azurerm_subnet.wppublicSubnet2.id
  route_table_id = azurerm_route_table.wp_route_table.id
}