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

resource "azurerm_storage_container" "sc" {
    name = "data"
    storage_account_name = azurerm_storage_account.sa.name
    container_access_type = "private"
}

resource "azurerm_storage_table" "st" {
    name = "data"
    storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_queue" "sq" {
    name = "data"
    storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_share" "ss" {
    name = "data"
    storage_account_name = azurerm_storage_account.sa.name
    quota = 50
}

# Azure Function App with Elastic Premium Plan
resource "azurerm_app_service_plan" "asp" {
    name                = "asp-cmhtfwidepl"
    location            = "eastus2"
    resource_group_name = data.azurerm_resource_group.rg.name
    kind                = "elastic"
    sku {
        tier = "ElasticPremium"
        size = "EP1"
    }
}

resource "azurerm_function_app" "fa" {
    name                      = "fa-cmhtfwidepl"
    location                  = "eastus2"
    resource_group_name       = data.azurerm_resource_group.rg.name
    app_service_plan_id       = azurerm_app_service_plan.asp.id
    storage_account_name      = azurerm_storage_account.sa.name
    storage_account_access_key = azurerm_storage_account.sa.primary_access_key
    version                   = "~3"
    app_settings = {
        "FUNCTIONS_WORKER_RUNTIME" = "node"
        "WEBSITE_NODE_DEFAULT_VERSION" = "14"
    }
}