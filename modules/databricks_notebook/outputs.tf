output "notebook_id" {
  description = "The ID of the notebook"
  value       = databricks_notebook.this.id
}

output "notebook_url" {
  description = "The URL of the notebook"
  value       = databricks_notebook.this.url
}

output "notebook" {
  description = "The full notebook resource"
  value       = databricks_notebook.this
}