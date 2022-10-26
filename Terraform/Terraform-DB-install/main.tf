
resource "azurerm_resource_group" "test" {
  name     = "robert-database"
  location = "East US"
}

resource "azurerm_mysql_server" "test" {
  name                = "robert-mysql"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  administrator_login          = "robert"
  administrator_login_password = "12345qwe!"

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
  name                = "test-db"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_mysql_server.test.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "test" {
  name                = "firewall-rule"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_mysql_server.test.name
  start_ip_address    = "86.120.48.159"
  end_ip_address      = "86.120.48.159"
}