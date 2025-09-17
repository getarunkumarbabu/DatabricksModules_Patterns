output "id" {
  description = "ID of the MLflow model"
  value       = databricks_mlflow_model.this.id
}

output "latest_versions" {
  description = "Latest versions of the MLflow model"
  value       = databricks_mlflow_model.this.latest_versions
}