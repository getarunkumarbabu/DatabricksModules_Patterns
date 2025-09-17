output "serving_endpoint_id" {
  description = "The ID of the model serving endpoint"
  value       = databricks_model_serving.this.id
}

output "serving_endpoint_url" {
  description = "The URL of the model serving endpoint"
  value       = databricks_model_serving.this.url
}

output "serving_endpoint" {
  description = "The full model serving endpoint resource"
  value       = databricks_model_serving.this
}