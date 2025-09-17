output "script_id" {
  description = "ID of the created init script"
  value       = databricks_global_init_script.this.id
}

output "script_name" {
  description = "Name of the init script"
  value       = databricks_global_init_script.this.name
}