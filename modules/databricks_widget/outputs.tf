output "widget_id" {
  description = "The ID of the created SQL widget"
  value       = databricks_sql_widget.this.id
}

output "query_id" {
  description = "The ID of the associated SQL query"
  value       = databricks_sql_widget.this.query_id
}

output "dashboard_id" {
  description = "The ID of the dashboard containing this widget"
  value       = databricks_sql_widget.this.dashboard_id
}

output "visualization_id" {
  description = "The ID of the visualization for this widget"
  value       = databricks_sql_widget.this.visualization_id
}

output "title" {
  description = "The title of the widget"
  value       = databricks_sql_widget.this.title
}