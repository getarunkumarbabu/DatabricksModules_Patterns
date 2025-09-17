output "query_id" {
  description = "ID of the created query"
  value       = databricks_sql_query.this.id
}

output "query_url" {
  description = "URL to the query in the Databricks SQL UI"
  value       = databricks_sql_query.this.url
}