output "webhook_id" {
  description = "The unique identifier for the MLflow webhook"
  value       = databricks_mlflow_webhook.this.id
}

output "webhook_status" {
  description = "The current status of the webhook (ACTIVE or DISABLED)"
  value       = databricks_mlflow_webhook.this.status
}

output "webhook_events" {
  description = "The list of events that trigger the webhook"
  value       = databricks_mlflow_webhook.this.events
}

output "webhook_url" {
  description = "The HTTP URL endpoint of the webhook, if configured"
  value       = try(databricks_mlflow_webhook.this.http_url_spec[0].url, null)
}

output "job_id" {
  description = "The ID of the job to trigger, if configured"
  value       = try(databricks_mlflow_webhook.this.job_spec[0].job_id, null)
}

output "created_at" {
  description = "The timestamp when the webhook was created"
  value       = databricks_mlflow_webhook.this.creation_timestamp
}

output "updated_at" {
  description = "The timestamp when the webhook was last updated"
  value       = databricks_mlflow_webhook.this.last_updated_timestamp
}