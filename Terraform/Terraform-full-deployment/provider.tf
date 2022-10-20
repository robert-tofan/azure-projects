terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
    kubectl = {
      source  = "Altinity/kubectl"
      version = "1.7.4"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.14.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "robert-project"
    storage_account_name = "robert260398"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "V5XSxmqQLjyvMIMdSSU7X2ByVqJFDk1aMNzoEv/mit7qRo/+0+0pVd1BJyrKUmuoccteswnLG9HD+ASt8uVfIw=="
  }
}

provider "azurerm" {
  features {}

}

provider "helm" {
  debug = true
  kubernetes {
    host = data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].host

    client_key             = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_key)
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].cluster_ca_certificate)
  }
}

provider "kubectl" {

  host = data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].host

  client_key             = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
}

provider "kubernetes" {
  host = data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].host

  client_key             = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.kube-cluster.kube_config[0].cluster_ca_certificate)

}