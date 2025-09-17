output "scope_name" {
  description = "Name of the created secret scope"
  value       = databricks_secret_scope.this.name
}
