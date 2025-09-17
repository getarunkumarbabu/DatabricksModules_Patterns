// Databricks cluster module
resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = var.node_type_id
  autotermination_minutes = var.autotermination_minutes

  autoscale {
    min_workers = var.autoscale_min_workers
    max_workers = var.autoscale_max_workers
  }

  spark_conf = var.spark_conf

  enable_elastic_disk = var.enable_elastic_disk
  custom_tags = var.custom_tags == null ? {} : var.custom_tags
}
