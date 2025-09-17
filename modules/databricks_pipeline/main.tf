resource "databricks_pipeline" "this" {
  name        = var.name
  storage     = var.storage
  target      = var.target
  channel     = var.channel
  edition     = var.edition
  photon     = var.photon

  dynamic "cluster" {
    for_each = var.cluster_config != null ? [var.cluster_config] : []
    content {
      label               = cluster.value.label
      num_workers        = cluster.value.num_workers
      min_workers       = cluster.value.min_workers
      max_workers       = cluster.value.max_workers
      driver_node_type_id = cluster.value.driver_node_type_id
      node_type_id       = cluster.value.node_type_id
      custom_tags        = cluster.value.custom_tags
    }
  }

  dynamic "library" {
    for_each = var.libraries
    content {
      maven {
        coordinates = library.value.maven_coordinates
      }
    }
  }

  dynamic "notification" {
    for_each = var.notifications != null ? [var.notifications] : []
    content {
      email_recipients = notification.value.email_recipients
      on_failure      = notification.value.on_failure
      on_success      = notification.value.on_success
    }
  }
}