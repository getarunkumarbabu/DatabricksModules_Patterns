resource "databricks_registered_model" "this" {
  name               = var.model_name
  description        = var.description
  catalog_name       = var.catalog_name
  schema_name        = var.schema_name
  storage_location   = var.storage_location
  tags               = var.tags

  dynamic "permission" {
    for_each = var.permissions != null ? [var.permissions] : []
    content {
      dynamic "privilege_assignments" {
        for_each = permission.value
        content {
          principal  = privilege_assignments.value.principal
          privileges = privilege_assignments.value.privileges
        }
      }
    }
  }
}