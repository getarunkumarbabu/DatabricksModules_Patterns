output "directory_path" {
  description = "The path of the created directory"
  value       = databricks_directory.this.path
}

output "object_id" {
  description = "The object ID of the created directory"
  value       = databricks_directory.this.object_id
}