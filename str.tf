provider "azurerm" {
  features {}
}
variable "rep_type"{
  type = map
  default = {
    default = "LRS"
    dev = "ZRS"
    prod = "GRS"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "new-mod-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "newmodestorageaccnt"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = lookup(var.rep_type,terraform.workspace)
  
}