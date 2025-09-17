resource "databricks_repo" "this" {
  url             = var.url
  path            = var.path
  branch          = var.branch
  tag             = var.tag
  provider_region = var.provider_region
}