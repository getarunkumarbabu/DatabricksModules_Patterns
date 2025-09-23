output "group_id" {
  description = "The ID of the created group"
  value       = databricks_account_group.this.id
}

output "display_name" {
  description = "The display name of the group"
  value       = databricks_account_group.this.display_name
}