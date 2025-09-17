output "external_location_id" {
  description = "The ID of the external location"
  value       = databricks_external_location.this.id
}

output "external_location" {
  description = "The full external location resource"
  value       = databricks_external_location.this
}