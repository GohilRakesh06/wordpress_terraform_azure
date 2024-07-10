


resource "azurerm_network_interface" "wp_nic" {
  name                = var.nic
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
   depends_on = [ azurerm_resource_group.wordpressrg ]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.wppublicSubnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wordpressvm_publicip.id
  }
}
resource "azurerm_public_ip" "wordpressvm_publicip" {
  name                = var.wordpressvm_public_ip
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
 depends_on = [ azurerm_resource_group.wordpressrg ]
  allocation_method = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "wordpress_vm" {
  name                = var.linux_virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.size_vm
  admin_username      =var.vm_username
  network_interface_ids = [
    azurerm_network_interface.wp_nic.id,
  ]

  admin_ssh_key {
    username   = var.vm_username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }
  depends_on = [ azurerm_resource_group.wordpressrg ]
  
     
}

 resource "null_resource" "remote1" {
   depends_on = [ azurerm_resource_group.wordpressrg ,  azurerm_public_ip.wordpressvm_publicip]
  connection {
        host = azurerm_public_ip.wordpressvm_publicip.ip_address
        user = "wordpressuser"
        type = "ssh"
        private_key = azapi_resource_action.ssh_public_key_gen.output.privateKey
        timeout = "4m"
        agent = false
        
    }
  provisioner "remote-exec" {
    
        inline = [
          "sudo mkdir tf_dir",
          "sudo yum install httpd -y",
          "sudo yum install git -y",
          "sudo yum install php -y",
          "sudo yum install mysql-server -y",
          "sudo yum install php-mysqlnd -y",
          "git clone https://github.com/WordPress/WordPress.git",
          //"sudo docker run -d -p 80:80 httpd"
          "sudo mv WordPress/* /var/www/html",
          "sudo chown -R apache /var/www/html/",
          "sudo chmod -R 755 /var/www/html",
          "sudo systemctl stop firewalld",
          "sudo chcon -R -t httpd_sys_content_t /var/www/html",
          "sudo systemctl restart httpd"
        ]
  }
}