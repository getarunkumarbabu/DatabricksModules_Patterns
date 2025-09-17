output "index_id" {
  description = "ID of the vector search index"
  value       = databricks_vector_search_index.this.id
}

output "index_status" {
  description = "Status of the vector search index"
  value       = databricks_vector_search_index.this.status
}