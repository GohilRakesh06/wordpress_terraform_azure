

resource "azurerm_public_ip" "wordpress_publicip" {
  name                = "wordpress_public_ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
   depends_on = [ azurerm_resource_group.wordpressrg ]
}

resource "azurerm_virtual_network_gateway" "wordpress_gateway" {
  name                = var.vnet_gateway_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
   depends_on = [ azurerm_resource_group.wordpressrg ]

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.wordpress_publicip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.wpGatewaySubnet.id 
  }

  
  
}