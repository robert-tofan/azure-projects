terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "3.26.0"
      }
    }
} 

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "robert_gr" {
    name     = "robert-day1"
    location = "East US"
    tags = {
        environment = "learn"
    }
}

resource "azurerm_virtual_network" "robert_vnw" {
    name = "robert_vnw"
    resource_group_name = azurerm_resource_group.robert_gr.name
    location            = azurerm_resource_group.robert_gr.location
    address_space       = ["10.123.0.0/16"]

     tags = {
        environment = "learn"
    }
}

resource "azurerm_subnet" "robert_sbnw" {
  name = "robert_sbnw"
  resource_group_name  = azurerm_resource_group.robert_gr.name
  virtual_network_name = azurerm_virtual_network.robert_vnw.name
  address_prefixes = ["10.123.1.0/24"]

}

resource "azurerm_network_security_group" "robert_secgr" {
    name = "robert_secgr"
    location            = azurerm_resource_group.robert_gr.location
    resource_group_name = azurerm_resource_group.robert_gr.name
    tags = {
        environment = "learn"
    }
  
}

resource "azurerm_network_security_rule" "robert_secrule" {
    name                        = "robert_secrule"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.robert_gr.name
    network_security_group_name = azurerm_network_security_group.robert_secgr.name

  
}

resource "azurerm_subnet_network_security_group_association" "robert_secgras" {
    subnet_id              = azurerm_subnet.robert_sbnw.id
    network_security_group_id = azurerm_network_security_group.robert_secgr.id
  
}

resource "azurerm_public_ip" "robert_ip" {
    name                = "robert_ip"
    resource_group_name = azurerm_resource_group.robert_gr.name
    location            = azurerm_network_security_group.robert_secgr.location
    allocation_method   = "Dynamic"
    tags = {
        environment = "learn"
    }
}

resource "azurerm_network_interface" "robert_nic" {
    name                = "robert_nic"
    location            = azurerm_resource_group.robert_gr.location
    resource_group_name = azurerm_resource_group.robert_gr.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.robert_sbnw.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.robert_ip.id
    }
     tags = {
        environment = "learn"
    }
}

resource "azurerm_linux_virtual_machine" "robert_vm" {
  name                  = "robert-vm"
  resource_group_name   = azurerm_resource_group.robert_gr.name
  location              = azurerm_resource_group.robert_gr.location
  size                  = "Standard_D2s_v3"
  admin_username        = "robert"
  network_interface_ids = [azurerm_network_interface.robert_nic.id]

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

data "azurerm_public_ip" "robert_ip-data" {
    name                = azurerm_public_ip.robert_ip.name
    resource_group_name = azurerm_resource_group.robert_gr.name
  
}

output "public_ip_address" {
    value = "${azurerm_linux_virtual_machine.robert_vm.name}: ${data.azurerm_public_ip.robert_ip-data.ip_address}"
  
}
