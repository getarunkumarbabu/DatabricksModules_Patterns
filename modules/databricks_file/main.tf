resource "databricks_file" "this" {
  path           = var.path
  source         = var.source_path
  content_base64 = var.content_base64
  md5            = var.md5
}