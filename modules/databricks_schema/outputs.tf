output "schema_id" {
  description = "The ID of the schema"
  value       = databricks_schema.this.id
}

output "schema" {
  description = "The full schema resource"
  value       = databricks_schema.this
}