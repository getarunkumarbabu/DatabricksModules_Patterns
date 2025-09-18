output "group_id" {
  description = "ID of the group"
  value       = databricks_group.this.id
}

output "group_name" {
  description = "Name of the group"
  value       = databricks_group.this.display_name
}

output "assigned_roles" {
  description = "List of roles assigned to the group"
  value       = var.roles
}