resource "azurerm_mysql_server" "test" {
  name                = var.mysql-name
  location            = data.azurerm_resource_group.test.location
  resource_group_name = data.azurerm_resource_group.test.name

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

  depends_on = [
    azurerm_mysql_server.test
  ]

  name                = var.name-database
  resource_group_name = data.azurerm_resource_group.test.name
  server_name         = var.mysql-name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

} // End of mysql database resource

resource "azurerm_mysql_firewall_rule" "test" {

  depends_on = [
    azurerm_mysql_server.test
  ]

  name                = var.firewall-name
  resource_group_name = data.azurerm_resource_group.test.name
  server_name         = var.mysql-name
  start_ip_address    = var.firewall-start-ip
  end_ip_address      = var.firewall-end-ip

} // End of firewall resource