resource "databricks_catalog" "this" {
  name         = var.name
  comment      = var.comment
  properties   = var.properties
  owner        = var.owner
  force_delete = var.force_delete
}