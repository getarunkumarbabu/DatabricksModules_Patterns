resource "databricks_global_init_script" "this" {
  name    = var.name
  content = var.content
  enabled = var.enabled

  position = var.position
}