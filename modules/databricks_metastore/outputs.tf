output "metastore_id" {
  description = "The ID of the metastore"
  value       = databricks_metastore.this.id
}

output "metastore" {
  description = "The full metastore resource"
  value       = databricks_metastore.this
}