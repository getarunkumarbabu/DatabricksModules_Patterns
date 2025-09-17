output "table_id" {
  description = "ID of the created table"
  value       = databricks_table.this.id
}

output "table_name" {
  description = "Full name of the table including catalog and schema"
  value       = "${databricks_table.this.catalog_name}.${databricks_table.this.schema_name}.${databricks_table.this.name}"
}

output "owner" {
  description = "Owner of the table"
  value       = databricks_table.this.owner
}

output "storage_location" {
  description = "Storage location of the table"
  value       = databricks_table.this.storage_location
}