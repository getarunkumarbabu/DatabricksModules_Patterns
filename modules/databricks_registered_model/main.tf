resource "databricks_registered_model" "this" {
  name         = var.model_name
  catalog_name = var.catalog_name
  schema_name  = var.schema_name
}