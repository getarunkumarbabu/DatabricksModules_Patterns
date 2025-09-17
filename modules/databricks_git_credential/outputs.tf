output "git_credential_id" {
  description = "The ID of the Git credential"
  value       = databricks_git_credential.this.id
}

output "git_credential" {
  description = "The full Git credential resource"
  value       = databricks_git_credential.this
  sensitive   = true
}