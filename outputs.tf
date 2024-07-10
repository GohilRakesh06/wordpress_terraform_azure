output "GatewaySubnet" {
  value = azurerm_subnet.wpGatewaySubnet.id
}

output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}

output "private_key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.privateKey
}

output "public_ip" {
  value = azurerm_public_ip.wordpressvm_publicip.ip_address
  
}