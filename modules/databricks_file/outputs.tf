output "file_path" {
  description = "Path of the created file in the workspace"
  value       = databricks_file.this.path
}

output "size" {
  description = "Size of the file in bytes"
  value       = databricks_file.this.size
}

output "object_id" {
  description = "Object ID of the file"
  value       = databricks_file.this.object_id
}