resource "databricks_permissions" "cluster_access" {
  cluster_id = var.cluster_id

  dynamic "access_control" {
    for_each = var.access_rules
    content {
      permission_level = access_control.value.permission_level
      user_name        = access_control.value.principal
    }
  }
}