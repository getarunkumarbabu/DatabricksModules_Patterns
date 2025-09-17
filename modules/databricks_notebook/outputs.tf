output "id" {
  description = "ID of the notebook"
  value       = databricks_notebook.this.id
}

output "url" {
  description = "URL of the notebook in the Databricks workspace"
  value       = databricks_notebook.this.url
}