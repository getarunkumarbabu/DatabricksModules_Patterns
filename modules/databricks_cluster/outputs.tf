output "cluster_id" {
  description = "ID of the created cluster"
  value       = databricks_cluster.this.id
}

output "cluster_name" {
  description = "Name of the created cluster"
  value       = databricks_cluster.this.cluster_name
}
