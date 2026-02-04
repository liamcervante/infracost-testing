
provider "aws" {}

resource "aws_s3_bucket" "bucket" {
  name = "my-name"
}

resource "azurerm_resource_group" "integration_wcs" {
  location = "eu-west-1"
  name     = "integrations"
}

resource "azurerm_storage_account" "integration_wcs" {
  location                 = azurerm_resource_group.integration_wcs.location
  name                     = azurerm_resource_group.integration_wcs.name
  account_replication_type = "replicate"
  account_tier             = "4"
  resource_group_name      = azurerm_resource_group.integration_wcs.name
}

resource "azurerm_app_service_plan" "integration_wcs" {
  name                         = azurerm_resource_group.integration_wcs.name
  location                     = azurerm_resource_group.integration_wcs.location
  resource_group_name          = azurerm_resource_group.integration_wcs.name
  tags                         = azurerm_resource_group.integration_wcs.tags
  kind                         = "elastic"
  maximum_elastic_worker_count = 1
  sku {
    tier     = "ElasticPremium"
    size     = "EP1"
    capacity = 1
  }
}

resource "azurerm_function_app" "integration_wcs" {
  for_each                   = toset(["one", "two"])
  name                       = each.key
  location                   = azurerm_resource_group.integration_wcs.location
  resource_group_name        = azurerm_resource_group.integration_wcs.name
  tags                       = azurerm_resource_group.integration_wcs.tags
  app_service_plan_id        = azurerm_app_service_plan.integration_wcs.id
  storage_account_name       = azurerm_storage_account.integration_wcs.name
  storage_account_access_key = azurerm_storage_account.integration_wcs.primary_access_key
  https_only                 = true
  version                    = "~4"
}
