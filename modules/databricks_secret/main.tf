resource "databricks_secret" "this" {
  key          = var.key
  string_value = var.string_value
  scope        = var.scope
}