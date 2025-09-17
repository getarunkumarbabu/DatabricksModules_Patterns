output "pipeline_id" {
  description = "ID of the created pipeline"
  value       = databricks_pipeline.this.id
}

output "pipeline_name" {
  description = "Name of the pipeline"
  value       = databricks_pipeline.this.name
}