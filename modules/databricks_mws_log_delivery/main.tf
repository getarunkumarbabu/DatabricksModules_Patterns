resource "databricks_mws_log_delivery" "this" {
  account_id           = var.account_id
  config_name          = var.config_name
  storage_configuration_id = var.storage_configuration_id
  
  log_type            = var.log_type
  output_format       = var.output_format
  delivery_path_prefix = var.delivery_path_prefix
  delivery_start_time = var.delivery_start_time
  status              = var.status

  credentials_id      = var.credentials_id
}