resource "databricks_mws_workspaces" "this" {
  account_id      = var.account_id
  workspace_name  = var.workspace_name
  deployment_name = var.deployment_name
  location        = var.location

  network_id               = var.network_id
  storage_configuration_id = var.storage_configuration_id
  credentials_id           = var.credentials_id

  pricing_tier = var.pricing_tier

  # Optional managed resource group name
  dynamic "managed_services" {
    for_each = var.managed_resource_group != null ? [1] : []
    content {
      customer_managed_key_id = null # Azure managed service configuration
    }
  }
}