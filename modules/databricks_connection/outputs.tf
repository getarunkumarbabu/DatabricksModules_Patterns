output "connection_id" {
  description = "Unique identifier for the created connection. Use this ID for references in other resources."
  value       = databricks_connection.this.id
}

output "connection_name" {
  description = "Name of the connection as shown in the Databricks workspace."
  value       = databricks_connection.this.name
}

output "owner" {
  description = "Username, service principal, or group that owns the connection."
  value       = databricks_connection.this.owner
}

output "metastore_id" {
  description = "ID of the Unity Catalog metastore this connection belongs to."
  value       = databricks_connection.this.metastore_id
}

output "connection_type" {
  description = "Type of the connection (MYSQL, POSTGRESQL, SNOWFLAKE, etc.)."
  value       = databricks_connection.this.connection_type
}

output "connection_info" {
  description = "Summary of the connection configuration, excluding sensitive data."
  value = {
    id            = databricks_connection.this.id
    name          = databricks_connection.this.name
    type          = databricks_connection.this.connection_type
    owner         = databricks_connection.this.owner
    metastore_id  = databricks_connection.this.metastore_id
    properties    = databricks_connection.this.properties
    options = {
      host       = try(databricks_connection.this.options[0].host, null)
      port       = try(databricks_connection.this.options[0].port, null)
      database   = try(databricks_connection.this.options[0].database, null)
      encrypt    = try(databricks_connection.this.options[0].encrypt, null)
      role       = try(databricks_connection.this.options[0].role, null)
      warehouse  = try(databricks_connection.this.options[0].warehouse, null)
    }
  }
}

output "created_by" {
  description = "Information about when and by whom the connection was created."
  value = {
    creator    = databricks_connection.this.created_by
    timestamp  = databricks_connection.this.created_at
  }
}

output "last_modified" {
  description = "Information about the last modification to the connection."
  value = {
    modifier   = databricks_connection.this.updated_by
    timestamp  = databricks_connection.this.updated_at
  }
}

output "connection_url" {
  description = "JDBC connection URL for the data source (when applicable)."
  value = coalesce(
    # MySQL
    try(format("jdbc:mysql://%s:%s/%s",
      databricks_connection.this.options[0].host,
      databricks_connection.this.options[0].port,
      databricks_connection.this.options[0].database
    ), null),
    # PostgreSQL
    try(format("jdbc:postgresql://%s:%s/%s",
      databricks_connection.this.options[0].host,
      databricks_connection.this.options[0].port,
      databricks_connection.this.options[0].database
    ), null),
    # SQL Server
    try(format("jdbc:sqlserver://%s:%s;database=%s",
      databricks_connection.this.options[0].host,
      databricks_connection.this.options[0].port,
      databricks_connection.this.options[0].database
    ), null),
    # Azure SQL Database
    try(format("jdbc:sqlserver://%s:%s;databaseName=%s",
      databricks_connection.this.options[0].host,
      databricks_connection.this.options[0].port,
      databricks_connection.this.options[0].database
    ), null),
    "Connection URL not available for this type"
  )
}