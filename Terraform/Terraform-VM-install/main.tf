
resource "azurerm_resource_group" "test" {
    name     = "robert-day1"
    location = "East US"
    tags = {
        environment = "learn"
    }
}

resource "azurerm_virtual_network" "test" {
    name = "robert_vnw"
    resource_group_name = azurerm_resource_group.test.name
    location            = azurerm_resource_group.test.location
    address_space       = ["10.123.0.0/16"]

     tags = {
        environment = "learn"
    }
}

resource "azurerm_subnet" "test" {
  name = "robert_sbnw"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes = ["10.123.1.0/24"]

}

resource "azurerm_network_security_group" "test" {
    name = "robert_secgr"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
    tags = {
        environment = "learn"
    }
  
}

resource "azurerm_network_security_rule" "test" {
    name                        = "robert_secrule"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.test.name
    network_security_group_name = azurerm_network_security_group.test.name

  
}

resource "azurerm_subnet_network_security_group_association" "test" {
    subnet_id              = azurerm_subnet.test.id
    network_security_group_id = azurerm_network_security_group.test.id
  
}

resource "azurerm_public_ip" "test" {
    name                = "robert_ip"
    resource_group_name = azurerm_resource_group.test.name
    location            = azurerm_network_security_group.test.location
    allocation_method   = "Dynamic"
    tags = {
        environment = "learn"
    }
}

resource "azurerm_network_interface" "test" {
    name                = "robert_nic"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.test.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.test.id
    }
     tags = {
        environment = "learn"
    }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "robert-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  size                  = "Standard_D2s_v3"
  admin_username        = "robert"
  network_interface_ids = [azurerm_network_interface.test.id]

  custom_data           = filebase64("customdata.sh")

   admin_ssh_key {
    username   = "andreea"
    public_key = file("C:/Users/ZZ0316826/.ssh/day1_rsa.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
        environment = "learn"
    }
 
}

data "azurerm_public_ip" "test" {
    name                = azurerm_public_ip.test.name
    resource_group_name = azurerm_resource_group.test.name
  
}

//save the public ip in output -> ip_address is the variable name from tfstate
// terraform output -> shows the public_ip_address output result
output "public_ip_address" {
    value = "${azurerm_linux_virtual_machine.test.name}: ${data.azurerm_public_ip.test.ip_address}"
  
}
