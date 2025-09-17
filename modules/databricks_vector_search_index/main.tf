resource "databricks_vector_search_index" "this" {
  name     = var.index_name
  endpoint_name = var.endpoint_name

  primary_key = var.primary_key
  index_type  = var.index_type
  delta_sync_index_spec = var.delta_sync_index_spec

  dynamic "source" {
    for_each = var.source != null ? [var.source] : []
    content {
      table    = source.value.table
      filter   = source.value.filter
      pipeline = source.value.pipeline
    }
  }

  dynamic "index_config" {
    for_each = var.index_config != null ? [var.index_config] : []
    content {
      embedding_source_columns = index_config.value.embedding_source_columns
      embedding_model_endpoint = index_config.value.embedding_model_endpoint
      embedding_vector_column = index_config.value.embedding_vector_column
      embedding_dimension     = index_config.value.embedding_dimension
      metric_type            = index_config.value.metric_type
    }
  }

  schema_json = jsonencode(var.schema)
}