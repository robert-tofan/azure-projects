data "azurerm_resource_group" "robert-project" {
  name = "robert-project"

}

/*data "azurerm_resource_group" "andreea-rg" {
  name = "andreea-rg"

}*/

/*
data "azurerm_public_ip" "public-ip" {

  name = "robert-public-ip"
  resource_group_name = data.azurerm_resource_group.robert-project.name

}
*/

data "azurerm_public_ip" "public-ip" {

  resource_group_name = data.azurerm_resource_group.robert-project.name
  name                = azurerm_public_ip.robert-public-ip.name
  depends_on = [
    azurerm_public_ip.robert-public-ip
  ]


}

data "azurerm_kubernetes_cluster" "kube-cluster" {

  resource_group_name = data.azurerm_resource_group.robert-project.name
  name                = azurerm_kubernetes_cluster.robert-kube.name


}

