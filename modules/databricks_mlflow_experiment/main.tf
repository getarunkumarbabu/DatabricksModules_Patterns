resource "databricks_mlflow_experiment" "this" {
  name              = var.name
  description       = var.description
  artifact_location = var.artifact_location
}