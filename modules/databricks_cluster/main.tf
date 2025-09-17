// Databricks cluster module
resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version          = var.spark_version
  node_type_id          = var.node_type_id
  driver_node_type_id   = var.driver_node_type_id
  instance_pool_id      = var.instance_pool_id
  policy_id             = var.policy_id
  autotermination_minutes = var.autotermination_minutes
  num_workers           = var.num_workers

  dynamic "autoscale" {
    for_each = var.autoscale_config != null ? [var.autoscale_config] : []
    content {
      min_workers = autoscale.value.min_workers
      max_workers = autoscale.value.max_workers
    }
  }

  spark_conf            = var.spark_conf
  spark_env_vars       = var.spark_env_vars
  custom_tags          = var.custom_tags
  enable_elastic_disk  = var.enable_elastic_disk
  enable_local_disk_encryption = var.enable_local_disk_encryption
  
  dynamic "workload_config" {
    for_each = var.workload_config != null ? [var.workload_config] : []
    content {
      workload_type = workload_config.value.workload_type
      configuration = workload_config.value.configuration
    }
  }

  dynamic "init_scripts" {
    for_each = var.init_scripts != null ? var.init_scripts : []
    content {
      dbfs {
        destination = init_scripts.value.destination
      }
    }
  }

  dynamic "library" {
    for_each = var.libraries != null ? var.libraries : []
    content {
      jar      = library.value.jar
      egg      = library.value.egg
      whl      = library.value.whl
      pypi     = library.value.pypi
      maven    = library.value.maven
      cran     = library.value.cran
    }
  }

  dynamic "cluster_log_conf" {
    for_each = var.cluster_log_conf != null ? [var.cluster_log_conf] : []
    content {
      dbfs {
        destination = cluster_log_conf.value.destination
      }
    }
  }

  dynamic "azure_attributes" {
    for_each = var.azure_attributes != null ? [var.azure_attributes] : []
    content {
      availability       = azure_attributes.value.availability
      first_on_demand   = azure_attributes.value.first_on_demand
      spot_bid_max_price = azure_attributes.value.spot_bid_max_price
    }
  }

  lifecycle {
    ignore_changes = [
      custom_tags["ClusterId"],
      custom_tags["ClusterName"]
    ]
  }
}
