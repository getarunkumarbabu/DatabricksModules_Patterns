output "metastore_id" {
  description = "ID of the assigned metastore"
  value       = databricks_metastore_assignment.assignment.metastore_id
}

output "workspace_id" {
  description = "ID of the workspace the metastore is assigned to"
  value       = databricks_metastore_assignment.assignment.workspace_id
}