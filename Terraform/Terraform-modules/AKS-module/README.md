This AKS module contain the following resources:
    - Azure Kubernetes Cluster
    - Azure Container Registry 
    - Helm chart for Nginx ingress controller
    - Helm chart for Cert Manager

This module needs as prerequiste an already creadted resource group.

The following variables are mandatory to be filled in:
    module "AKS-module" {

  resource-group-name = "<name of resource group created>"
  source         = "<path to module>"      

  //AKS variables

  aks-name       = "<name of kubernetes cluster>"
  aks-dns-prefix = "<prefix for DNS>"
  aks-vm-size    = "<size of VM (i.e. Standard_B2s)> "
  nodepool-name  = "<name for node pool>"
  aks-node-count = <number of nodes>

  // Helm ingress-contorller

  nginx-name      = "<name of nginx ingress>"
  nginx-namespace = "<name of nginx namespace>"

  // Helm cert-manager

  cert-manager-name      = "<name of cert manager>"
  cert-manager-namespace = "<name of cert manager namespace>"

  // ACR resource variables

  acr-name = "<name of Azure Container Registry>"
  acr-sku  = "<ACR tier (i.e. Basic)>"
}
