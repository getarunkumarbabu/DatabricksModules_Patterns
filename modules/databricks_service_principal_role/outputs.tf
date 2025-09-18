output "service_principal_id" {
  description = "ID of the service principal"
  value       = databricks_service_principal.this.id
}

output "service_principal_name" {
  description = "Name of the service principal"
  value       = databricks_service_principal.this.display_name
}

output "application_id" {
  description = "Application ID of the service principal"
  value       = databricks_service_principal.this.application_id
}

output "assigned_roles" {
  description = "List of roles assigned to the service principal"
  value       = var.roles
}