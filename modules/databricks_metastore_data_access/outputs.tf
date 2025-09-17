output "metastore_id" {
  description = "ID of the metastore"
  value       = databricks_metastore_data_access.access.metastore_id
}

output "name" {
  description = "Name of the data access configuration"
  value       = databricks_metastore_data_access.access.name
}

output "access_connector_id" {
  description = "Azure access connector ID"
  value       = databricks_metastore_data_access.access.azure_managed_identity[0].access_connector_id
}