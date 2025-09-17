output "dashboard_id" {
  description = "The unique identifier for the SQL dashboard"
  value       = databricks_sql_dashboard.this.id
}

output "dashboard_url" {
  description = "The URL to access the dashboard in the Databricks workspace"
  value       = databricks_sql_dashboard.this.url
}

output "dashboard_name" {
  description = "The name of the dashboard"
  value       = databricks_sql_dashboard.this.name
}

output "dashboard_tags" {
  description = "The tags associated with the dashboard"
  value       = databricks_sql_dashboard.this.tags
}

output "created_at" {
  description = "The timestamp when the dashboard was created"
  value       = databricks_sql_dashboard.this.created_at
}

output "updated_at" {
  description = "The timestamp when the dashboard was last updated"
  value       = databricks_sql_dashboard.this.updated_at
}