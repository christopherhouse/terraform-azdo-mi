terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    random = { 
        source  = "hashicorp/random"
        version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name    = "rg-tf"
    storage_account_name   = "cmhtfstatesa"
    container_name         = "tfstate"
    key                    = "terraform.tfstate"
    use_oidc = true
    client_id = "f4c5cd5b-3a07-427d-94ed-848501abda7b"
    subscription_id = "8bd05b2f-62c5-4def-9869-f0617ebb3970"
    tenant_id = "76de2d2d-77f8-438d-9a87-01806f2345da"
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}

  use_msi = true
  subscription_id = "8bd05b2f-62c5-4def-9869-f0617ebb3970"
  client_id = "f4c5cd5b-3a07-427d-94ed-848501abda7b"
  tenant_id = "76de2d2d-77f8-438d-9a87-01806f2345da"
}
