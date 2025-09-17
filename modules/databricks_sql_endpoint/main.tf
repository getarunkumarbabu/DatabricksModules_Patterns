resource "databricks_sql_endpoint" "this" {
  name                      = var.name
  cluster_size             = var.cluster_size
  min_num_clusters         = var.min_num_clusters
  max_num_clusters         = var.max_num_clusters
  auto_stop_mins           = var.auto_stop_mins
  enable_photon            = var.enable_photon
  enable_serverless        = var.enable_serverless
  warehouse_type          = var.warehouse_type
  spot_instance_policy    = var.spot_instance_policy
  tags                    = var.tags
  enable_preview_features = var.enable_preview_features
  instance_profile_arn    = var.instance_profile_arn
  data_source_id         = var.data_source_id

  dynamic "channel" {
    for_each = var.channel != null ? [var.channel] : []
    content {
      name = channel.value
    }
  }
}