resource "databricks_sql_widget" "this" {
  query_id = var.query_id
  dashboard_id = var.dashboard_id
  visualization_id = var.visualization_id

  title = var.title
  type  = var.type
  width = var.width

  options = jsonencode(var.options)

  dynamic "parameter_mappings" {
    for_each = var.parameter_mappings != null ? [var.parameter_mappings] : []
    content {
      name       = parameter_mappings.value.name
      type       = parameter_mappings.value.type
      mapTo      = parameter_mappings.value.map_to
      default    = parameter_mappings.value.default
      title      = parameter_mappings.value.title
      value      = parameter_mappings.value.value
      global     = parameter_mappings.value.global
    }
  }
}