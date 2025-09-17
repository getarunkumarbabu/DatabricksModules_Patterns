resource "databricks_external_location" "this" {
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
  comment         = var.comment
  owner           = var.owner

  dynamic "read_only" {
    for_each = var.read_only != null ? [1] : []
    content {
      value = var.read_only
    }
  }
}