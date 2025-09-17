output "connection_id" {
  description = "ID of the created connection"
  value       = databricks_connection.this.id
}

output "connection_name" {
  description = "Name of the connection"
  value       = databricks_connection.this.name
}

output "owner" {
  description = "Owner of the connection"
  value       = databricks_connection.this.owner
}

output "metastore_id" {
  description = "ID of the metastore this connection belongs to"
  value       = databricks_connection.this.metastore_id
}