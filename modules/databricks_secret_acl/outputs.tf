output "acl_id" {
  description = "The unique identifier for the secret ACL"
  value       = databricks_secret_acl.this.id
}

output "principal" {
  description = "The principal granted permissions"
  value       = databricks_secret_acl.this.principal
}

output "scope" {
  description = "The secret scope name"
  value       = databricks_secret_acl.this.scope
}

output "permission" {
  description = "The granted permission level"
  value       = databricks_secret_acl.this.permission
}