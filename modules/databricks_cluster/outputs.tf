output "cluster_id" {
  description = "Unique identifier of the cluster. Use this ID for job configurations, notebook attachments, and other cluster references."
  value       = databricks_cluster.this.id
}

output "cluster_name" {
  description = "Display name of the cluster as shown in the Databricks workspace."
  value       = databricks_cluster.this.cluster_name
}

output "default_tags" {
  description = "System tags automatically added by Databricks for cluster management and billing."
  value       = databricks_cluster.this.default_tags
}

output "state" {
  description = "Current operational state of the cluster (PENDING, RUNNING, RESTARTING, RESIZING, TERMINATING, TERMINATED, ERROR)."
  value       = databricks_cluster.this.state
}

output "state_message" {
  description = "Detailed message about the current cluster state, useful for troubleshooting."
  value       = databricks_cluster.this.state_message
}

output "spark_version" {
  description = "Full Spark version running on the cluster, including detailed build information."
  value       = databricks_cluster.this.spark_version
}

output "jdbc_url" {
  description = "JDBC connection URL for this cluster. Use this to connect external tools and applications."
  value       = databricks_cluster.this.jdbc_url
  sensitive   = true
}

output "cluster_cores" {
  description = "Total number of CPU cores across all nodes in the cluster (driver + workers)."
  value       = databricks_cluster.this.cluster_cores
}

output "cluster_memory_mb" {
  description = "Total amount of memory in MB across all nodes in the cluster (driver + workers)."
  value       = databricks_cluster.this.cluster_memory_mb
}

output "cluster_size" {
  description = "Current size configuration of the cluster."
  value = var.autoscale_config != null ? {
    mode         = "autoscale"
    min_workers  = var.autoscale_config.min_workers
    max_workers  = var.autoscale_config.max_workers
    current_size = databricks_cluster.this.num_workers
    } : {
    mode         = "fixed"
    num_workers  = var.num_workers
    current_size = databricks_cluster.this.num_workers
  }
}

output "cluster_configuration" {
  description = "Complete cluster configuration details for reference."
  value = {
    node_types = {
      driver = coalesce(var.driver_node_type_id, var.node_type_id)
      worker = var.node_type_id
    }
    auto_termination = var.autotermination_minutes
    features = {
      elastic_disk          = var.enable_elastic_disk
      local_disk_encryption = var.enable_local_disk_encryption
    }
    custom_tags    = var.custom_tags
    spark_conf     = var.spark_conf
    spark_env_vars = var.spark_env_vars
    libraries      = var.libraries
  }
}

output "azure_attributes" {
  description = "Azure-specific attributes of the cluster configuration."
  value = var.azure_attributes != null ? {
    availability       = var.azure_attributes.availability
    first_on_demand    = var.azure_attributes.first_on_demand
    spot_bid_max_price = var.azure_attributes.spot_bid_max_price
    vm_type = {
      driver = coalesce(var.driver_node_type_id, var.node_type_id)
      worker = var.node_type_id
    }
  } : null
}

