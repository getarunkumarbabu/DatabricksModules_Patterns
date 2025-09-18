resource "databricks_dbfs_file" "this" {
  path   = var.path
  source = var.source
}