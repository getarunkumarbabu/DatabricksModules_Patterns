resource "databricks_sql_query" "this" {
  name           = var.name
  warehouse_id   = var.warehouse_id
  data_source_id = var.data_source_id
  query          = var.query
  run_as_role    = var.run_as_role

  dynamic "parameter" {
    for_each = var.parameters != null ? var.parameters : []
    content {
      name        = parameter.value.name
      title       = parameter.value.title
      type        = parameter.value.type
      value       = parameter.value.value
    }
  }

  dynamic "schedule" {
    for_each = var.schedule_enabled ? [1] : []
    content {
      continuous {
        interval_seconds = var.schedule_interval_seconds
      }
      quartz_cron_expression = var.schedule_cron_expression
      pause_status = var.schedule_paused ? "PAUSED" : "UNPAUSED"
    }
  }

  dynamic "options" {
    for_each = var.query_options != null ? [var.query_options] : []
    content {
      run_as_role = var.run_as_role
      cell_size   = options.value.cell_size
    }
  }
}