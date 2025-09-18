resource "databricks_mws_private_access_settings" "this" {
  private_access_settings_name = var.private_access_settings_name
  region                       = var.region
  public_access_enabled        = var.public_access_enabled

  # Azure-specific private access configuration
  # The private endpoint connections will be managed through the Azure provider
  # and linked to these private access settings via the workspace configuration
}