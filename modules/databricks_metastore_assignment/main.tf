resource "databricks_metastore_assignment" "assignment" {
  metastore_id = var.metastore_id
  workspace_id = var.workspace_id
}