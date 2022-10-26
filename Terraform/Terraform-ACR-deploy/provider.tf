terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "robert260398"
    storage_account_name = "robertstorageacc"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "SPp1MxhdsWBEM/Uqi2Bg6CApX5cUcKVci5f4d1Q777cqnu/FMJeN7uPNomPhmGtRaj/EL34eWOag+AStXkViKA=="
  }
}

provider "azurerm" {
  features {}

}