output "service_principal_id" {
  description = "The ID of the created service principal"
  value       = databricks_service_principal.this.id
}

output "application_id" {
  description = "The application ID of the service principal"
  value       = databricks_service_principal.this.application_id
}

output "display_name" {
  description = "The display name of the service principal"
  value       = databricks_service_principal.this.display_name
}

output "roles" {
  description = "List of roles assigned to the service principal"
  value       = var.roles
}