output "view_id" {
  description = "The ID of the created SQL view"
  value       = databricks_sql_view.this.id
}

output "view_name" {
  description = "The name of the SQL view"
  value       = databricks_sql_view.this.name
}

output "catalog_name" {
  description = "The name of the catalog containing the view"
  value       = databricks_sql_view.this.catalog
}

output "schema_name" {
  description = "The name of the schema containing the view"
  value       = databricks_sql_view.this.schema
}