resource "databricks_metastore" "this" {
  name          = var.name
  storage_root  = var.storage_root
  region        = var.region
  owner         = var.owner
  force_destroy = var.force_destroy
}