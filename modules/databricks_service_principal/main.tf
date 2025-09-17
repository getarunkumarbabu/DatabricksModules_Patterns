resource "databricks_service_principal" "this" {
  display_name               = var.display_name
  allow_cluster_create      = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  force                     = var.force
  active                    = var.active
}