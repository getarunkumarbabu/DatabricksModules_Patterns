resource "databricks_grant" "this" {
  principal  = var.principal
  privileges = var.privileges

  dynamic "catalog" {
    for_each = var.catalog_name != null ? [1] : []
    content {
      name = var.catalog_name
    }
  }

  dynamic "schema" {
    for_each = var.schema_name != null && var.schema_catalog_name != null ? [1] : []
    content {
      name          = var.schema_name
      catalog_name = var.schema_catalog_name
    }
  }

  dynamic "table" {
    for_each = var.table_name != null && var.table_schema_name != null && var.table_catalog_name != null ? [1] : []
    content {
      name          = var.table_name
      schema_name  = var.table_schema_name
      catalog_name = var.table_catalog_name
    }
  }

  dynamic "volume" {
    for_each = var.volume_name != null && var.volume_schema_name != null && var.volume_catalog_name != null ? [1] : []
    content {
      name          = var.volume_name
      schema_name  = var.volume_schema_name
      catalog_name = var.volume_catalog_name
    }
  }
}