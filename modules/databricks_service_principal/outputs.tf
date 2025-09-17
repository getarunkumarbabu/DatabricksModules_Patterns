output "service_principal_id" {
  description = "ID of the created service principal"
  value       = databricks_service_principal.this.id
}

output "application_id" {
  description = "Application ID of the service principal"
  value       = databricks_service_principal.this.application_id
}

output "display_name" {
  description = "Display name of the service principal"
  value       = databricks_service_principal.this.display_name
}