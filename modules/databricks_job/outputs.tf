output "job_id" {
  description = "ID of the created job"
  value       = databricks_job.this.id
}
