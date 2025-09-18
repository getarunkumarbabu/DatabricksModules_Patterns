output "credentials_id" {
  description = "ID of the created credentials"
  value       = databricks_mws_credentials.this.credentials_id
}

output "creation_time" {
  description = "Time when the credentials were created"
  value       = databricks_mws_credentials.this.creation_time
}