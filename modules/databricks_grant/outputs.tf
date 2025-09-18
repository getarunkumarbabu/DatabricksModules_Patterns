output "principal" {
  description = "The principal that was granted privileges"
  value       = databricks_grant.this.principal
}

output "privileges" {
  description = "The privileges that were granted"
  value       = databricks_grant.this.privileges
}

output "object_type" {
  description = "The type of object that privileges were granted on"
  value = coalesce(
    var.catalog_name != null ? "CATALOG" : null,
    var.schema_name != null ? "SCHEMA" : null,
    var.table_name != null ? "TABLE" : null,
    var.volume_name != null ? "VOLUME" : null
  )
}

output "object_name" {
  description = "The full name of the object that privileges were granted on"
  value = coalesce(
    var.catalog_name != null ? var.catalog_name : null,
    var.schema_name != null ? "${var.schema_catalog_name}.${var.schema_name}" : null,
    var.table_name != null ? "${var.table_catalog_name}.${var.table_schema_name}.${var.table_name}" : null,
    var.volume_name != null ? "${var.volume_catalog_name}.${var.volume_schema_name}.${var.volume_name}" : null
  )
}