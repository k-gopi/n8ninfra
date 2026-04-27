terraform {
  backend "azurerm" {
    resource_group_name  = "n8n-tfstate-dev-rg"
    storage_account_name = "n8ntfstatedevsa"
    container_name       = "n8n-tfstate"
    key                  = "dev.tfstate"
  }
}