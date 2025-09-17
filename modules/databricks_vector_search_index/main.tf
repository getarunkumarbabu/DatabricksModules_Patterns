resource "databricks_vector_search_index" "this" {
  name     = var.index_name
  endpoint = var.endpoint_name

  primary_key = var.primary_key
  index_type  = var.index_type

  dynamic "source" {
    for_each = var.source != null ? [var.source] : []
    content {
      table = source.value.table
      filter = source.value.filter
      pipeline = source.value.pipeline
    }
  }

  schema_json = jsonencode(var.schema)
}