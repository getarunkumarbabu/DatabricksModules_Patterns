output "policy_id" {
  description = "ID of the created cluster policy"
  value       = databricks_cluster_policy.this.id
}

output "policy_name" {
  description = "Name of the created policy"
  value       = databricks_cluster_policy.this.name
}