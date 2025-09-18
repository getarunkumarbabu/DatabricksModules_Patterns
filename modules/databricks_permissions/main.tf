resource "databricks_permissions" "this" {
  sql_endpoint_id = var.sql_endpoint_id
  cluster_id      = var.cluster_id
  job_id          = var.job_id
  notebook_path   = var.notebook_path
  pipeline_id     = var.pipeline_id

  dynamic "access_control" {
    for_each = var.access_controls
    content {
      group_name             = access_control.value.group_name
      service_principal_name = access_control.value.service_principal_name
      user_name              = access_control.value.user_name
      permission_level       = access_control.value.permission_level
    }
  }
}