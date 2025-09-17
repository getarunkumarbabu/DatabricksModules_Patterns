resource "databricks_sql_query" "this" {
  name           = var.name
  data_source_id = var.data_source_id
  query          = var.query
}