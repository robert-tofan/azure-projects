output "public-ip" {

  value = azurerm_public_ip.robert-public-ip[*].ip_address

}