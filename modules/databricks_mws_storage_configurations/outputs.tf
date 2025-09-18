output "storage_configuration_id" {
  description = "ID of the created storage configuration"
  value       = databricks_mws_storage_configurations.this.storage_configuration_id
}

output "creation_time" {
  description = "Time when the storage configuration was created"
  value       = databricks_mws_storage_configurations.this.creation_time
}

output "storage_configuration_name" {
  description = "Name of the storage configuration"
  value       = databricks_mws_storage_configurations.this.storage_configuration_name
}