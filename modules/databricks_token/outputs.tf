output "token_id" {
  description = "ID of the created token"
  value       = databricks_token.this.token_id
}

output "token_value" {
  description = "Token value (sensitive)"
  value       = databricks_token.this.token_value
  sensitive   = true
}