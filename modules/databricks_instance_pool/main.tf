
resource "databricks_instance_pool" "this" {
  instance_pool_name               = var.name
  min_idle_instances               = var.min_idle_instances
  max_capacity                     = var.max_capacity
  node_type_id                     = var.node_type_id
  idle_instance_autotermination_minutes = var.idle_instance_autotermination_minutes

  aws_attributes {
    availability = var.aws_availability
  }
}
