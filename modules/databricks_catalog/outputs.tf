output "catalog_id" {
  description = "The unique identifier of the catalog"
  value       = databricks_catalog.this.id
}

output "catalog_name" {
  description = "The name of the catalog"
  value       = databricks_catalog.this.name
}

output "full_name" {
  description = "The fully qualified name of the catalog (including metastore if applicable)"
  value       = databricks_catalog.this.full_name
}

output "owner" {
  description = "The owner of the catalog"
  value       = databricks_catalog.this.owner
}

output "metadata" {
  description = "Metadata about the catalog including creation and last updated timestamps"
  value = {
    created_at     = databricks_catalog.this.created_at
    created_by     = databricks_catalog.this.created_by
    last_updated_at = databricks_catalog.this.last_updated_at
    last_updated_by = databricks_catalog.this.last_updated_by
  }
}

output "properties" {
  description = "The merged properties and tags of the catalog"
  value       = databricks_catalog.this.properties
}

output "isolation_mode" {
  description = "The isolation mode of the catalog"
  value       = databricks_catalog.this.isolation_mode
}

output "provider_details" {
  description = "Details about the storage provider if this is an external catalog"
  value = {
    provider_name = databricks_catalog.this.provider_name
    storage_root  = databricks_catalog.this.storage_root
  }
}

output "catalog" {
  description = "The complete catalog resource object"
  value       = databricks_catalog.this
}