resource "databricks_permissions" "this" {
  cluster_policy_id = var.cluster_policy_id
  instance_pool_id  = var.instance_pool_id
  job_id           = var.job_id
  notebook_path    = var.notebook_path
  workspace_path   = var.workspace_path

  dynamic "access_control" {
    for_each = var.access_controls
    content {
      permission_level = access_control.value.permission_level
      user_name       = lookup(access_control.value, "user_name", null)
      group_name      = lookup(access_control.value, "group_name", null)
      service_principal_name = lookup(access_control.value, "service_principal_name", null)
    }
  }
}