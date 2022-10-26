
resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mysql_server" "test" {
  name                = var.mysql-name
  location            = var.location
  resource_group_name = var.resource_group_name

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
}

resource "azurerm_mysql_database" "test" {
  for_each = {
    "db1" = {resource_group_name="robert-database", location="East US", server_name="robert-mysql" }
    "db2" = {resource_group_name="robert-database", location="East US", server_name="robert-mysql" }
  }

  name                = each.key 
  resource_group_name = each.value.resource_group_name
  server_name         = each.value.server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on = [
    azurerm_resource_group.test, azurerm_mysql_server.test
  ]
}

resource "azurerm_mysql_firewall_rule" "test" {
  name                = "firewall-rule"
  resource_group_name = var.resource_group_name
  server_name         = var.mysql-name
  start_ip_address    = "86.120.48.135"
  end_ip_address      = "86.120.48.135"
}