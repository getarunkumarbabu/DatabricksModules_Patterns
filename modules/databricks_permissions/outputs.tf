output "object_type" {
  description = "Type of object permissions were set on"
  value       = databricks_permissions.this.object_type
}

output "object_id" {
  description = "ID of the object permissions were set on"
  value       = databricks_permissions.this.object_id
}