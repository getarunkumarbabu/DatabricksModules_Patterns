output "log_delivery_configuration_id" {
  description = "ID of the created log delivery configuration"
  value       = databricks_mws_log_delivery.this.log_delivery_configuration_id
}

output "status" {
  description = "Current status of the log delivery configuration"
  value       = databricks_mws_log_delivery.this.status
}

output "creation_time" {
  description = "Time when the configuration was created"
  value       = databricks_mws_log_delivery.this.creation_time
}

output "config_name" {
  description = "Name of the log delivery configuration"
  value       = databricks_mws_log_delivery.this.config_name
}