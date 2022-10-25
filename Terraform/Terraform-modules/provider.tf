terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.28.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "robert-project"
    storage_account_name = "robert260398"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "YHsICg/c5FquGSXJvLY1C0A1hmuMAqUOHn80omGDxi/MpL5KrxUtWDLDrs5NXg6/dnyk4tHQeG4e+AStf8HCGg=="
  }
}

provider "azurerm" {
  features {}

}
