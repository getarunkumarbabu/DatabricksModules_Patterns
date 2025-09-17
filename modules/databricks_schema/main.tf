resource "databricks_schema" "this" {
  catalog_name = var.catalog_name
  name         = var.name
  comment      = var.comment
  properties   = var.properties
  owner        = var.owner
}