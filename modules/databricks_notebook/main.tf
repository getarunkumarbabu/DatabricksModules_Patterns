resource "databricks_notebook" "this" {
  path     = var.path
  language = var.language
  source   = var.source
  format   = var.format

  dynamic "cluster" {
    for_each = var.cluster_id != null ? [var.cluster_id] : []
    content {
      id = cluster.value
    }
  }
}