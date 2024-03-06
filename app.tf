provider azurerm {
    features{}
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

  
}
