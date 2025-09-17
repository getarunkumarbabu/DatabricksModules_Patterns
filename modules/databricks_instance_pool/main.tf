
resource "databricks_instance_pool" "this" {
  instance_pool_name                     = var.name
  min_idle_instances                     = var.min_idle_instances
  max_capacity                           = var.max_capacity
  node_type_id                          = var.node_type_id
  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes
  enable_elastic_disk                   = var.enable_elastic_disk
  preloaded_spark_versions              = var.preloaded_spark_versions
  custom_tags                           = var.custom_tags

  dynamic "aws_attributes" {
    for_each = var.aws_attributes != null ? [var.aws_attributes] : []
    content {
      availability            = aws_attributes.value.availability
      zone_id                = aws_attributes.value.zone_id
      spot_bid_price_percent = aws_attributes.value.spot_bid_price_percent
    }
  }

  dynamic "azure_attributes" {
    for_each = var.azure_attributes != null ? [var.azure_attributes] : []
    content {
      availability        = azure_attributes.value.availability
      spot_bid_max_price = azure_attributes.value.spot_bid_max_price
    }
  }

  dynamic "disk_spec" {
    for_each = var.disk_spec != null ? [var.disk_spec] : []
    content {
      disk_type {
        ebs_volume_type = disk_spec.value.disk_type.ebs_volume_type
      }
      disk_count = disk_spec.value.disk_count
      disk_size  = disk_spec.value.disk_size
    }
  }

  dynamic "preloaded_docker_image" {
    for_each = var.preloaded_docker_images != null ? var.preloaded_docker_images : []
    content {
      url = preloaded_docker_image.value.url
      dynamic "basic_auth" {
        for_each = preloaded_docker_image.value.basic_auth != null ? [preloaded_docker_image.value.basic_auth] : []
        content {
          username = basic_auth.value.username
          password = basic_auth.value.password
        }
      }
    }
  }
}
