output "secret_key" {
  description = "The key of the secret"
  value       = databricks_secret.this.key
}

output "secret_scope" {
  description = "The scope containing the secret"
  value       = databricks_secret.this.scope
}