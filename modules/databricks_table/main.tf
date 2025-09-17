resource "databricks_table" "this" {
  name               = var.name
  catalog_name       = var.catalog_name
  schema_name        = var.schema_name
  table_type        = var.table_type
  data_source_format = var.data_source_format
  comment           = var.comment
  owner             = var.owner

  dynamic "column" {
    for_each = var.columns
    content {
      name      = column.value.name
      type_name = column.value.type_name
      type_text = column.value.type_text
      position  = column.value.position
      comment   = lookup(column.value, "comment", null)
      nullable  = lookup(column.value, "nullable", true)
    }
  }

  storage_location = var.storage_location

  dynamic "partition" {
    for_each = var.partition_columns != null ? [var.partition_columns] : []
    content {
      columns = partition.value
    }
  }

  dynamic "cluster_keys" {
    for_each = var.cluster_keys != null ? [var.cluster_keys] : []
    content {
      columns = cluster_keys.value
    }
  }

  properties = var.properties

  dynamic "tblproperties" {
    for_each = var.tblproperties != null ? [var.tblproperties] : []
    content {
      properties = tblproperties.value
    }
  }
}