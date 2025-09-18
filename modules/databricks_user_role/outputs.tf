output "user_id" {
  description = "ID of the user"
  value       = databricks_user.this.id
}

output "user_name" {
  description = "Username (email) of the user"
  value       = databricks_user.this.user_name
}

output "display_name" {
  description = "Display name of the user"
  value       = databricks_user.this.display_name
}

output "assigned_roles" {
  description = "List of roles assigned to the user"
  value       = var.roles
}