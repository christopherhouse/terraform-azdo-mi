data "azurerm_resource_group" "rg" {
  name = "rg-tf"
}

resource "azurerm_storage_account" "sa" {
    resource_group_name = data.azurerm_resource_group.rg.name
    location = "eastus2"

    name = "sacmhtfwidepl"

    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
}