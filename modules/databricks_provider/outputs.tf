output "provider_id" {
  description = "ID of the created provider"
  value       = databricks_provider.this.id
}

output "provider_name" {
  description = "Name of the provider"
  value       = databricks_provider.this.name
}

output "profile_str" {
  description = "The recipient profile configuration"
  value       = databricks_provider.this.recipient_profile_str
  sensitive   = true
}