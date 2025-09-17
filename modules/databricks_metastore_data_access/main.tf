resource "databricks_metastore_data_access" "access" {
  name         = var.name
  metastore_id = var.metastore_id
  owner        = var.owner
  
  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }

  is_default = var.is_default
  comment    = var.comment
}