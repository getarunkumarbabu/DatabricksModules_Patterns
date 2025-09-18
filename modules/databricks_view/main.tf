resource "databricks_sql_view" "this" {
  name       = var.name
  catalog    = var.catalog
  schema     = var.schema
  comment    = var.comment
  query      = var.sql
  cluster_id = var.cluster_id
  is_temp    = var.is_temp

  dynamic "grants" {
    for_each = var.permissions != null ? [var.permissions] : []
    content {
      dynamic "privilege_assignments" {
        for_each = grants.value
        content {
          principal  = privilege_assignments.value.principal
          privileges = privilege_assignments.value.privileges
        }
      }
    }
  }
}