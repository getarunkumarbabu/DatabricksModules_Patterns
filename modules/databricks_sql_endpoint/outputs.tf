output "sql_endpoint_id" {
  description = "ID of the created SQL warehouse"
  value       = databricks_sql_endpoint.this.id
}

output "sql_endpoint_name" {
  description = "Name of the SQL warehouse"
  value       = databricks_sql_endpoint.this.name
}

output "jdbc_url" {
  description = "JDBC URL for the SQL warehouse"
  value       = databricks_sql_endpoint.this.jdbc_url
}