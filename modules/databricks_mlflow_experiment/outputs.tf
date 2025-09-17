output "experiment_id" {
  description = "The ID of the MLflow experiment"
  value       = databricks_mlflow_experiment.this.id
}

output "experiment" {
  description = "The full MLflow experiment resource"
  value       = databricks_mlflow_experiment.this
}