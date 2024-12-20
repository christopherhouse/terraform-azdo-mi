terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
    random = {
        source  = "hashicorp/random"
        version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}

  use_msi = true
  subscription_id = "8bd05b2f-62c5-4def-9869-f0617ebb3970"
  arm_client_id = "f4c5cd5b-3a07-427d-94ed-848501abda7b"
  tenant_id = "76de2d2d-77f8-438d-9a87-01806f2345da"
}
