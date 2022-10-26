This MySQL Server contains the following:
   ```
 - MySQL Server with the following configuration:

            -sku_name   = "B_Gen5_1"
            -storage_mb = 5120
            -version    = "5.7"

            -auto_grow_enabled                 = false
            -backup_retention_days             = 7
            -geo_redundant_backup_enabled      = false
            -infrastructure_encryption_enabled = false
            -public_network_access_enabled     = true
            -ssl_enforcement_enabled           = true
            -ssl_minimal_tls_version_enforced  = "TLS1_0"
            
    - A database resource 
    - A firewall rule for MySQL Server
```

This module needs as prerequiste an already creadted resource group.

The following variables are mandatory to be filled in:
```
module "mysql-module" {

  resource-group-name = "<name of resource group created>"
  source              = "<path to module>"

  // MySQL variables

  mysql-name        = "<name of mysql server>"
  mysql-server-user = "<username fo mysql>"
  mysql-server-pass = "<password for mysql user>"

  // Databse variables

  name-database = "<name for database>"

  //Firewall variables

  firewall-name     = "<name for firewall>"
  firewall-start-ip = "<start range for ip>"
  firewall-end-ip   = "<end range for ip>"

} //End of mysql modules
```