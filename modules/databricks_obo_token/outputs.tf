output "token_value" {
  description = "The generated token value (sensitive)"
  value       = databricks_obo_token.this.token_value
  sensitive   = true
}

output "token_id" {
  description = "The unique identifier for the token"
  value       = databricks_obo_token.this.token_id
}

output "creation_time" {
  description = "The timestamp when the token was created"
  value       = databricks_obo_token.this.creation_time
}

output "expiry_time" {
  description = "The timestamp when the token will expire"
  value       = databricks_obo_token.this.expiry_time
}

output "token_info" {
  description = "The complete token information excluding sensitive data"
  value = {
    application_id   = databricks_obo_token.this.application_id
    comment         = databricks_obo_token.this.comment
    creation_time   = databricks_obo_token.this.creation_time
    expiry_time     = databricks_obo_token.this.expiry_time
    token_id        = databricks_obo_token.this.token_id
  }
}