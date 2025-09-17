resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version          = var.spark_version
  node_type_id           = var.node_type_id
  autotermination_minutes = var.autotermination_minutes
  spark_conf             = var.spark_conf
  custom_tags            = var.custom_tags

  num_workers = var.num_workers

  dynamic "library" {
    for_each = var.libraries
    content {
      jar = try(library.value.jar, null)
      whl = try(library.value.whl, null)
    }
  }

  dynamic "init_scripts" {
    for_each = var.init_scripts
    content {
      file {
        destination = init_scripts.value
      }
    }
  }
}