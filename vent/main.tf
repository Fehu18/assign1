resource "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg5" {
  name     = "example-resources"
  location = "West Europe"
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

    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = "kv12"
  location                    = "west europe"
  resource_group_name         = "example-resources"
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
}
resource "azurerm_app_service_plan" "app" {
  name                = "app1"
  location            = "west europe"
  resource_group_name = "example-resources"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appse" {
  name                = "appse1"
  location            = "west europe"
  resource_group_name = "example-resources"
  app_service_plan_id = azurerm_app_service_plan.app.id

  

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  

