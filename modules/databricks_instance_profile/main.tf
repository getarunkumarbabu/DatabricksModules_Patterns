resource "databricks_instance_profile" "this" {
  instance_profile_arn     = var.instance_profile_arn
  skip_validation          = var.skip_validation
  is_meta_instance_profile = var.is_meta_instance_profile
}