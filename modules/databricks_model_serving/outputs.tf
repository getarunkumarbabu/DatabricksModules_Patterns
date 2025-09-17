output "serving_endpoint_id" {
  description = "ID of the model serving endpoint"
  value       = databricks_model_serving.this.serving_endpoint_id
}

output "endpoint_url" {
  description = "URL of the serving endpoint"
  value       = databricks_model_serving.this.endpoint_url
}