resource "databricks_mws_storage_configurations" "this" {
  account_id                 = var.account_id
  storage_configuration_name = var.storage_configuration_name
  bucket_name               = var.container_name

  # Azure-specific storage configuration
  # The storage account and container must be configured separately using the azurerm provider
  # This resource only registers the storage configuration with Databricks
}