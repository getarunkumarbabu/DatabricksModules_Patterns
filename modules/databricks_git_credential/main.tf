resource "databricks_git_credential" "this" {
  git_username          = var.git_username
  git_provider         = var.git_provider
  personal_access_token = var.personal_access_token
  force                = var.force
}