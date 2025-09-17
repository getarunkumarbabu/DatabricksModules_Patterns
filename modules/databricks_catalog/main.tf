resource "databricks_catalog" "this" {
  name            = var.name
  comment         = var.comment
  properties      = merge(var.properties, var.tags)
  owner           = var.owner
  isolation_mode  = var.isolation_mode
  provider_name   = var.provider_name
  storage_root    = var.storage_root

  lifecycle {
    precondition {
      condition     = var.provider_name != null && var.storage_root != null || var.provider_name == null && var.storage_root == null
      error_message = "Both provider_name and storage_root must be set for external catalogs, or neither for managed catalogs."
    }
  }
}