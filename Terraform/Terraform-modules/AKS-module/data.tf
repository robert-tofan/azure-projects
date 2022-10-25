data "azurerm_resource_group" "test" {
  name = var.resource-group-name

}

data "azurerm_kubernetes_cluster" "test" {

  resource_group_name = data.azurerm_resource_group.test.name
  name                = azurerm_kubernetes_cluster.test.name


}

