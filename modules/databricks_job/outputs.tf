output "job_id" {
  description = "The unique identifier for the created job"
  value       = databricks_job.this.id
}

output "job_url" {
  description = "The URL to access the job in the Databricks workspace"
  value       = databricks_job.this.url
}

output "job_settings" {
  description = "The complete job settings configuration"
  value       = databricks_job.this.settings
}

output "job_name" {
  description = "The name of the job"
  value       = databricks_job.this.name
}

output "created_time" {
  description = "The timestamp when the job was created"
  value       = databricks_job.this.created_time
}

output "creator" {
  description = "The user or service principal that created the job"
  value       = databricks_job.this.creator_user_name
}

output "schedule" {
  description = "The job schedule configuration, if any"
  value       = try(databricks_job.this.schedule, null)
}

output "run_as" {
  description = "The service principal or user that the job runs as"
  value       = try(databricks_job.this.run_as, null)
}

output "format" {
  description = "The job format (SINGLE_TASK, MULTI_TASK)"
  value       = databricks_job.this.format
}

output "tags" {
  description = "The tags associated with the job"
  value       = try(databricks_job.this.tags, {})
}
