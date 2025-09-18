resource "databricks_mws_networks" "this" {
  account_id   = var.account_id
  network_name = var.network_name
  workspace_id = var.workspace_id

  # Azure-specific network configuration will be managed outside this module
  # through the azurerm provider, and the network details will be passed
  # via the workspace configuration
}