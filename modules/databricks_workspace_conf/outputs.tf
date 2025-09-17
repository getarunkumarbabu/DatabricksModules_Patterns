output "workspace_conf" {
  description = "The workspace configuration that was set"
  value       = databricks_workspace_conf.this.custom_config
}