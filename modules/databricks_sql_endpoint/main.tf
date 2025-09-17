resource "databricks_sql_endpoint" "this" {
  name                = var.name
  cluster_size        = var.cluster_size
  min_num_clusters    = var.min_num_clusters
  max_num_clusters    = var.max_num_clusters
  auto_stop_mins      = var.auto_stop_mins
  enable_photon       = var.enable_photon
  warehouse_type      = var.warehouse_type
  spot_instance_policy = var.spot_instance_policy

  dynamic "channel" {
    for_each = var.channel != null ? [var.channel] : []
    content {
      name = channel.value
    }
  }
}