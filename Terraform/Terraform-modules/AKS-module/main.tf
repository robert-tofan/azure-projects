resource "azurerm_kubernetes_cluster" "test" {
  //count               = var.if-aks ? 1 : 0
  name                = var.aks-name
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name
  dns_prefix          = var.aks-dns-prefix

  default_node_pool {
    name       = var.nodepool-name
    node_count = var.aks-node-count
    vm_size    = var.aks-vm-size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "learn"
  }

} // End of AKS resource

resource "helm_release" "ingress" {
  depends_on       = [data.azurerm_kubernetes_cluster.test]
  name             = var.nginx-name
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = var.nginx-namespace
  create_namespace = true
} // End of nginx ingress



resource "helm_release" "cert-manager" {
  depends_on       = [data.azurerm_kubernetes_cluster.test]
  name             = var.cert-manager-name
  repository       = "https://charts.jetstack.io/"
  chart            = "cert-manager"
  version          = "v1.10.0"
  namespace        = var.cet-manager-namespace
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
} // End of cert manager

resource "azurerm_container_registry" "test" {
  # count               = var.if-acr ? 1 : 0
  name                = var.acr-name
  resource_group_name = data.azurerm_resource_group.test.name
  location            = data.azurerm_resource_group.test.location
  sku                 = var.acr-sku
  admin_enabled       = false


} // End of ACR resource