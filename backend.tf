terraform {
  backend "azurerm" {
    resource_group_name  = "base-resources"
    storage_account_name = "storageaccountbward"
    container_name       = "tfstate"
    key                  = "sandbox.tfstate"
  }
}