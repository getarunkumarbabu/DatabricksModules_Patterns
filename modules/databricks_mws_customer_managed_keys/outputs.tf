output "customer_managed_key_id" {
  description = "ID of the customer managed key configuration"
  value       = databricks_mws_customer_managed_keys.this.id
}

output "use_cases" {
  description = "List of use cases for the customer managed keys"
  value       = databricks_mws_customer_managed_keys.this.use_cases
}

output "key_info" {
  description = "Azure Key Vault key information"
  value       = var.key_info
  sensitive   = true
}