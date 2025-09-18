output "private_access_settings_id" {
  description = "ID of the created private access settings"
  value       = databricks_mws_private_access_settings.this.private_access_settings_id
}

output "creation_time" {
  description = "Time when the private access settings were created"
  value       = databricks_mws_private_access_settings.this.creation_time
}

output "status" {
  description = "Current status of the private access settings"
  value       = databricks_mws_private_access_settings.this.status
}