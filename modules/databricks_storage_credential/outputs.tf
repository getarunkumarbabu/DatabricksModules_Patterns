output "storage_credential_id" {
  description = "ID of the created storage credential"
  value       = databricks_storage_credential.this.id
}

output "storage_credential_name" {
  description = "Name of the created storage credential"
  value       = databricks_storage_credential.this.name
}

output "owner" {
  description = "Owner of the storage credential"
  value       = databricks_storage_credential.this.owner
}