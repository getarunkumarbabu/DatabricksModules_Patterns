output "index_id" {
  description = "The ID of the created vector search index"
  value       = databricks_vector_search_index.this.id
}

output "index_name" {
  description = "The name of the vector search index"
  value       = databricks_vector_search_index.this.name
}

output "endpoint_name" {
  description = "The name of the endpoint for the vector search index"
  value       = databricks_vector_search_index.this.endpoint_name
}

output "status" {
  description = "The current status of the vector search index"
  value       = databricks_vector_search_index.this.status
}