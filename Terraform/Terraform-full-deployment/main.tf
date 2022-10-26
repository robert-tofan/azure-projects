resource "azurerm_kubernetes_cluster" "test" {
  name                = var.aks-name
  location            = data.azurerm_resource_group.robert-project.location
  resource_group_name = data.azurerm_resource_group.robert-project.name
  dns_prefix          = var.aks-dns-prefix

  default_node_pool {
    name       = "default"
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
  depends_on       = [data.azurerm_kubernetes_cluster.kube-cluster]
  name             = "robert-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-ns"
  create_namespace = true
} // End of nginx ingress



resource "helm_release" "cert_manager" {
  depends_on       = [data.azurerm_kubernetes_cluster.kube-cluster]
  name             = "robert-nginx"
  repository       = "https://charts.jetstack.io/"
  chart            = "cert-manager"
  version          = "v1.10.0"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
} // End of cert manager

resource "azurerm_mysql_server" "test" {
  count               = var.if-mysql ? 1 : 0
  name                = var.mysql-name
  location            = data.azurerm_resource_group.robert-project.location
  resource_group_name = data.azurerm_resource_group.robert-project.name

  administrator_login          = var.mysql-server-user
  administrator_login_password = var.mysql-server-pass

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_0"

  tags = {
    environment = "learn"
  }

} // End of MySql resource

resource "azurerm_mysql_database" "test" {

  count               = var.if-mysql-db ? 1 : 0
  name                = "test-db"
  resource_group_name = data.azurerm_resource_group.robert-project.name
  server_name         = var.mysql-name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

} // End of mysql database resource

resource "azurerm_mysql_firewall_rule" "test" {

  count               = var.if-firewall ? 1 : 0
  name                = "firewall-rule"
  resource_group_name = data.azurerm_resource_group.robert-project.name
  server_name         = var.mysql-name
  start_ip_address    = var.firewall-ip
  end_ip_address      = var.firewall-ip

} // End of firewall resource

resource "azurerm_container_registry" "test" {
  count               = var.if-acr ? 1 : 0
  name                = var.acr-name
  resource_group_name = data.azurerm_resource_group.robert-project.name
  location            = data.azurerm_resource_group.robert-project.location
  sku                 = var.acr-sku
  admin_enabled       = false


} // End of ACR resource

resource "azurerm_public_ip" "test" {
  name                = "robert-public-ip"
  resource_group_name = data.azurerm_resource_group.robert-project.name
  location            = data.azurerm_resource_group.robert-project.location
  allocation_method   = "Static"

  tags = {
    environment = "learn"
  }
} // End of public ip resource

resource "azurerm_dns_zone" "test" {

  name                = "robert.com"
  resource_group_name = data.azurerm_resource_group.robert-project.name

} // End of DNS zone resource

resource "azurerm_dns_a_record" "test" {

  name                = "robert-a-record"
  zone_name           = azurerm_dns_zone.test.name
  resource_group_name = data.azurerm_resource_group.robert-project.name
  ttl                 = 300
  target_resource_id  = data.azurerm_public_ip.public-ip.id
  depends_on = [
    data.azurerm_public_ip.public-ip
  ]

} // Enf of A record resource
