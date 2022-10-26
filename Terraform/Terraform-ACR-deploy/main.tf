
resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "test" {
  count    =var.smekerie ? 1 : 0
  name                = "${var.prefix}260398"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false

 
}