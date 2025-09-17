output "repo_path" {
  description = "Path where the repository is mounted"
  value       = databricks_repo.this.path
}

output "repo_id" {
  description = "ID of the repository"
  value       = databricks_repo.this.id
}

output "head_commit_id" {
  description = "HEAD commit ID"
  value       = databricks_repo.this.head_commit_id
}