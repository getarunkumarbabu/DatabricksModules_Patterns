output "catalog_id" {
  description = "The ID of the catalog"
  value       = databricks_catalog.this.id
}

output "catalog" {
  description = "The full catalog resource"
  value       = databricks_catalog.this
}