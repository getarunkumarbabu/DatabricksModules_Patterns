output "dbfs_path" {
  description = "The path where the file is stored in DBFS"
  value       = databricks_dbfs_file.this.path
}

output "file_size" {
  description = "The size of the file in bytes"
  value       = databricks_dbfs_file.this.file_size
}

output "dbfs_file_id" {
  description = "The unique identifier of the file in DBFS"
  value       = databricks_dbfs_file.this.id
}