module "AKS-module" {

  resource-group-name = "robert-project"
  source              = "./AKS-module"


  //AKS variables

  aks-name       = "robert-kube"
  aks-dns-prefix = "dns-prefix"
  aks-vm-size    = "Standard_B2s"
  nodepool-name  = "default"
  aks-node-count = 1

  // Helm ingress-contorller

  nginx-name      = "neginx-test"
  nginx-namespace = "nginx-ingress"

  // Helm cert-manager

  cert-manager-name      = "cert-manager"
  cert-manager-namespace = "cert-manager"

  // ACR resource variables

  acr-name = "robert260398"
  acr-sku  = "Basic"
}

module "mysql-module" {

  resource-group-name = "robert-project"
  source              = "./mysql-module"

  // MySQL variables

  mysql-name        = "mysql-server-robert"
  mysql-server-user = "robert"
  mysql-server-pass = "12345qwe!"

  // Databse variables

  name-database = "test-db"

  //Firewall variables

  firewall-name     = "firewall"
  firewall-start-ip = "86.120.48.135"
  firewall-end-ip   = "86.120.48.135"

} //End of mysql modules
