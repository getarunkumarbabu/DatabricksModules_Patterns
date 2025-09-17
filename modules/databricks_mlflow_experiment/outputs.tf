output "id" {
  description = "ID of the MLflow experiment"
  value       = databricks_mlflow_experiment.this.id
}

output "experiment_id" {
  description = "Experiment ID"
  value       = databricks_mlflow_experiment.this.experiment_id
}