resource "databricks_obo_token" "this" {
  application_id   = var.application_id
  comment          = var.comment
  lifetime_seconds = var.lifetime_seconds
}