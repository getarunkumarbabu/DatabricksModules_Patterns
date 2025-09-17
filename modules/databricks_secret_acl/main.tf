resource "databricks_secret_acl" "this" {
  principal  = var.principal
  scope     = var.scope
  permission = var.permission
}