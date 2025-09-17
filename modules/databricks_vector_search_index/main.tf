resource "databricks_vector_search_index" "this" {
  name          = var.name
  endpoint_name = var.endpoint_name
  index_type    = "VECTOR_SEARCH"
  primary_key   = var.primary_key
}