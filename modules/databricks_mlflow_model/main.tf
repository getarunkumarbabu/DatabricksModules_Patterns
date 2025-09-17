resource "databricks_mlflow_model" "this" {
  name              = var.name
  description       = var.description
  tags              = var.tags
}