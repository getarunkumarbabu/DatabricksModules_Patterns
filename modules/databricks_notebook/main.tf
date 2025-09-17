resource "databricks_notebook" "this" {
  path     = var.path
  language = var.language
  source   = var.source
  format   = var.format
}