output "workspace_id" {
  description = "ID of the created workspace"
  value       = databricks_mws_workspaces.this.workspace_id
}

output "workspace_name" {
  description = "Name of the workspace"
  value       = databricks_mws_workspaces.this.workspace_name
}

output "workspace_status" {
  description = "Current status of the workspace"
  value       = databricks_mws_workspaces.this.workspace_status
}

output "workspace_url" {
  description = "URL of the workspace"
  value       = databricks_mws_workspaces.this.workspace_url
}