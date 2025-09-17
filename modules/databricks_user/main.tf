resource "databricks_user" "this" {
  user_name    = var.user_name
  display_name = var.display_name
  active       = var.active
  force        = var.force
}