terraform {

  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}
provider "azurerm"{
   features {}
  skip_provider_registration = true
  subscription_id = "dd841e0c-a76f-4d5d-ae2f-b0645b248ae5"
}
/*resource "azurerm_resource_group" "rg5" {
  name     = var.rname
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  location            = azurerm_resource_group.rg5.location
  resource_group_name = azurerm_resource_group.rg5.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    
  }

  tags = {
    environment = "Production"
  }
}

    
data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = "keyvault01a"
  location                    = azurerm_resource_group.rg5.location
  resource_group_name         = azurerm_resource_group.rg5.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
       
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
} */
 resource "azurerm_service_plan" "app" {
  name                = "app1"
  location            = "westeurope"
  resource_group_name = "example-resources"
  os_type             = "Linux"
  sku_name            = "B1"
  }


  resource "azurerm_linux_web_app" "appse" {
  name                = "appse1"
  location            = "westeurope"
  resource_group_name = "example-resources"
  service_plan_id = azurerm_service_plan.app.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
}


  } 



  

