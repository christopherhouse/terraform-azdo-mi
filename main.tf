data "azurerm_resource_group" "rg" {
  name = "rg-tf"
}

resource "azurerm_storage_account" "sa" {
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "eastus2"

  name = "sacmhtfwidepl"

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "sc" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "st" {
  name                 = "data"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_queue" "sq" {
  name                 = "data"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_share" "ss" {
  name                 = "data"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 50
}
