resource "databricks_sql_view" "this" {
  name        = var.view_name
  catalog     = var.catalog_name
  schema      = var.schema_name
  comment     = var.comment
  query       = var.query
  cluster_id  = var.cluster_id
  is_temp     = var.is_temp

  dynamic "grants" {
    for_each = var.grants != null ? [var.grants] : []
    content {
      dynamic "privilege_assignments" {
        for_each = grants.value
        content {
          principal = privilege_assignments.value.principal
          privileges = privilege_assignments.value.privileges
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      comment,
      query
    ]
  }
}