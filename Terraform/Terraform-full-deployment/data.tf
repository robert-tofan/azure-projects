data "azurerm_resource_group" "robert-project" {
  name = "robert-project"

}

data "azurerm_public_ip" "public-ip" {

  resource_group_name = data.azurerm_resource_group.robert-project.name
  name                = azurerm_public_ip.test.name
  depends_on = [
    azurerm_public_ip.test
  ]


}

data "azurerm_kubernetes_cluster" "kube-cluster" {

  resource_group_name = data.azurerm_resource_group.robert-project.name
  name                = azurerm_kubernetes_cluster.test.name


}

