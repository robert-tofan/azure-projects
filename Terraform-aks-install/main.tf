resource "azurerm_resource_group" "robert-aks" {
  name     = "robert-aks"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "robert-kube" {
  name                = "robert-kube"
  location            = azurerm_resource_group.robert-aks.location
  resource_group_name = azurerm_resource_group.robert-aks.name
  dns_prefix          = "test-prefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "learn"
  }

}

