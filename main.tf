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

# Azure Service Bus Standard SKU with a topic named 'orders' and a queue
# named 'status'
resource "azurerm_servicebus_namespace" "sb" {
  name                = "sbcmhtfwidepl"
  location            = azurerm_storage_account.sa.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  tags = {
    environment = "production"
  }
}

resource "azurerm_servicebus_topic" "st" {
  name                = "orders"
  namespace_id = sb.id
}

resource "azurerm_servicebus_queue" "sq" {
  name                = "status"
  namespace_id = sb.id
}