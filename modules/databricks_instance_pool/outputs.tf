output "instance_pool_id" {
  description = "ID of the instance pool"
  value       = databricks_instance_pool.this.id
}

output "instance_pool_name" {
  description = "Name of the instance pool"
  value       = databricks_instance_pool.this.instance_pool_name
}

output "min_idle_instances" {
  description = "Minimum number of idle instances"
  value       = databricks_instance_pool.this.min_idle_instances
}

output "max_capacity" {
  description = "Maximum capacity of the instance pool"
  value       = databricks_instance_pool.this.max_capacity
}

output "node_type_id" {
  description = "Node type ID used in the instance pool"
  value       = databricks_instance_pool.this.node_type_id
}

output "preloaded_spark_versions" {
  description = "List of preloaded Spark versions"
  value       = databricks_instance_pool.this.preloaded_spark_versions
}

output "state" {
  description = "Current state of the instance pool"
  value       = databricks_instance_pool.this.state
}

output "stats" {
  description = "Statistics about the instance pool"
  value       = databricks_instance_pool.this.stats
}

output "idle_instance_autotermination_minutes" {
  description = "Time in minutes after which idle instances are terminated"
  value       = databricks_instance_pool.this.idle_instance_autotermination_minutes
}

output "enable_elastic_disk" {
  description = "Whether elastic disk optimization is enabled"
  value       = databricks_instance_pool.this.enable_elastic_disk
}

output "custom_tags" {
  description = "Custom tags applied to instances in the pool"
  value       = databricks_instance_pool.this.custom_tags
}



output "azure_attributes" {
  description = "Azure-specific attributes of the instance pool"
  value       = var.azure_attributes
}

output "disk_spec" {
  description = "Disk specification of instances in the pool"
  value       = var.disk_spec
}

output "preloaded_docker_images" {
  description = "Docker images preloaded on instances in the pool"
  value       = var.preloaded_docker_images
  sensitive   = true
}

output "pool_info" {
  description = "Combined pool information for easy reference"
  value = {
    id                = databricks_instance_pool.this.id
    name              = databricks_instance_pool.this.instance_pool_name
    state             = databricks_instance_pool.this.state
    node_type         = databricks_instance_pool.this.node_type_id
    current_capacity  = try(databricks_instance_pool.this.stats.used_count, 0)
    idle_count        = try(databricks_instance_pool.this.stats.idle_count, 0)
    pending_count     = try(databricks_instance_pool.this.stats.pending_count, 0)
  }
}
