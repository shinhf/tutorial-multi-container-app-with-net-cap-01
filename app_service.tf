resource "azurerm_app_service_plan" "main" {
  name                = "asp-${var.app_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B2"
  }
  tags = {
    environment = var.env
  }
}

resource "azurerm_app_service" "main" {
  name                = "as-${var.app_name}-${var.env}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  tags = {
    environment = var.env
  }

  identity {
    type = "SystemAssigned"
  }

    logs {
    http_logs {
      file_system {
        retention_in_mb   = 30 # in Megabytes
        retention_in_days = 2  # in days
      }
    }
  }
  site_config {
    linux_fx_version                     = "COMPOSE|${filebase64("docker-compose.yml")}"
    acr_use_managed_identity_credentials = "true"
    always_on                            = "true"
  }
}