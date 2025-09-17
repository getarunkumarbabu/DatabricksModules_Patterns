resource "databricks_external_location" "this" {
  name            = var.name
  url             = var.url
  credential_name = var.credential_name
  comment         = var.comment
  owner           = var.owner
  skip_validation = var.skip_validation

  dynamic "read_only" {
    for_each = var.read_only != null ? [1] : []
    content {
      value = var.read_only
    }
  }

  lifecycle {
    precondition {
      condition     = can(regex("^abfss://", var.url))
      error_message = "External location URL must use ABFS protocol for Azure storage (abfss://)."
    }
  }
}