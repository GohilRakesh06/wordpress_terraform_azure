resource "azurerm_virtual_network" "wordpress_virtual_network" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5" , "8.8.8.8"]
  depends_on = [ azurerm_resource_group.wordpressrg ]
}

resource "azurerm_subnet" "wpGatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wordpress_virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
   depends_on = [ azurerm_resource_group.wordpressrg  , azurerm_virtual_network.wordpress_virtual_network]
}

resource "azurerm_subnet" "wppublicSubnet1" {
  name                 = "wppublicSubnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wordpress_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [ azurerm_resource_group.wordpressrg  , azurerm_virtual_network.wordpress_virtual_network]
}

resource "azurerm_subnet" "wppublicSubnet2" {
  name                 = "wppublicSubnet2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wordpress_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [ azurerm_resource_group.wordpressrg  , azurerm_virtual_network.wordpress_virtual_network]
   delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      
    }
}
}
resource "azurerm_subnet" "wpprivateSubnet1" {
  name                 = "wpprivateSubnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wordpress_virtual_network.name
  address_prefixes     = ["10.0.3.0/24"]
  depends_on = [ azurerm_resource_group.wordpressrg  , azurerm_virtual_network.wordpress_virtual_network]
}

resource "azurerm_subnet" "wpprivateSubnet2" {
  name                 = "wpprivateSubnet2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wordpress_virtual_network.name
  address_prefixes     = ["10.0.4.0/24"]
  depends_on = [ azurerm_resource_group.wordpressrg  , azurerm_virtual_network.wordpress_virtual_network]
}

