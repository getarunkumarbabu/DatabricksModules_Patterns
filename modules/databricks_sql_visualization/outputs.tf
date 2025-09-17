output "visualization_id" {
  description = "ID of the created SQL visualization"
  value       = databricks_sql_visualization.visualization.id
}

output "visualization_url" {
  description = "URL of the created SQL visualization"
  value       = databricks_sql_visualization.visualization.url
}