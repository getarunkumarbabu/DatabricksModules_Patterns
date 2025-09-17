output "library_status" {
  description = "Status of the library installation"
  value       = databricks_library.this.library_status
}