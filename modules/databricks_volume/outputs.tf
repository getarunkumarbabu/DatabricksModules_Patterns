output "volume_id" {
  description = "ID of the created volume"
  value       = databricks_volume.this.id
}

output "volume_name" {
  description = "Full name of the volume including catalog and schema"
  value       = "${databricks_volume.this.catalog_name}.${databricks_volume.this.schema_name}.${databricks_volume.this.name}"
}

output "owner" {
  description = "Owner of the volume"
  value       = databricks_volume.this.owner
}

output "storage_location" {
  description = "Storage location of the volume"
  value       = databricks_volume.this.storage_location
}