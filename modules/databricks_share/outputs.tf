output "share_id" {
  description = "ID of the created share"
  value       = databricks_share.this.id
}

output "share_name" {
  description = "Name of the share"
  value       = databricks_share.this.name
}

output "owner" {
  description = "Owner of the share"
  value       = databricks_share.this.owner
}