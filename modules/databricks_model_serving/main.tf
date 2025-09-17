resource "databricks_model_serving" "this" {
  name = var.name
  
  config {
    served_models {
      name                      = var.model_name
      model_name               = var.model_name
      model_version           = var.model_version
      workload_size          = var.workload_size
      scale_to_zero_enabled = var.scale_to_zero_enabled
    }
  }
}