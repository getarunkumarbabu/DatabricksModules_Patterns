output "script_id" {
  description = "ID of the created init script"
  value       = databricks_global_init_script.this.id
}

output "script_name" {
  description = "Name of the init script"
  value       = databricks_global_init_script.this.name
}

output "enabled" {
  description = "Whether the init script is enabled"
  value       = databricks_global_init_script.this.enabled
}

output "position" {
  description = "The execution position of the init script"
  value       = databricks_global_init_script.this.position
}

output "created_at" {
  description = "Timestamp when the init script was created"
  value       = databricks_global_init_script.this.created_at
}

output "updated_at" {
  description = "Timestamp when the init script was last updated"
  value       = databricks_global_init_script.this.updated_at
}

output "source_path" {
  description = "DBFS source path of the init script if provided"
  value       = var.source
}