output "recipient_id" {
  description = "ID of the created recipient"
  value       = databricks_recipient.this.id
}

output "recipient_name" {
  description = "Name of the recipient"
  value       = databricks_recipient.this.name
}

output "owner" {
  description = "Owner of the recipient"
  value       = databricks_recipient.this.owner
}

output "activation_url" {
  description = "Activation URL for the recipient (if token-based authentication)"
  value       = databricks_recipient.this.activation_url
  sensitive   = true
}