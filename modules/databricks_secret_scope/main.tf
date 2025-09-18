resource "databricks_secret_scope" "this" {
  name                     = var.name
  initial_manage_principal = var.initial_manage_principal
}

// Optionally create databricks_secret resources for each key/value in secrets_map
resource "databricks_secret" "secrets" {
  for_each = var.secrets_map == null ? {} : var.secrets_map

  key          = each.key
  string_value = each.value
  scope        = databricks_secret_scope.this.name
}
