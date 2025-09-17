resource "databricks_mlflow_model" "this" {
  name = var.name
  // Remove tags and description as they are not supported in the current version
}