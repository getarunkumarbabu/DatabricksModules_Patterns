resource "databricks_directory" "this" {
  path = var.path

  lifecycle {
    # Prevent accidental deletion of directories that might contain important data
    prevent_destroy = true
  }
}