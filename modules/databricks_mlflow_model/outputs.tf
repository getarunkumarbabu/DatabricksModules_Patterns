output "model_id" {
  description = "The ID of the MLflow model"
  value       = databricks_mlflow_model.this.id
}

output "model" {
  description = "The full MLflow model resource"
  value       = databricks_mlflow_model.this
}