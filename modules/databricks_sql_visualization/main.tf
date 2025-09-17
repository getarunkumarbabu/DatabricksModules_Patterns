resource "databricks_sql_visualization" "visualization" {
  query_id    = var.query_id
  name        = var.name
  type        = "VISUALIZATION"
  description = var.description
  options     = jsonencode(var.options)
}