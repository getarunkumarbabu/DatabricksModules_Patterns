resource "databricks_service_principal" "this" {
  display_name               = var.display_name
  allow_cluster_create      = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  force                     = var.force
  active                    = var.active
  application_id            = var.application_id

  dynamic "external_id" {
    for_each = var.aad_object_id != null ? [var.aad_object_id] : []
    content {
      id = external_id.value
    }
  }
}