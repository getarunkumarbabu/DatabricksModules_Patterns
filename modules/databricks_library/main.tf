resource "databricks_library" "this" {
  cluster_id = var.cluster_id

  dynamic "maven" {
    for_each = var.maven_coordinates != null ? [1] : []
    content {
      coordinates = var.maven_coordinates
      repo        = var.maven_repo
    }
  }

  dynamic "pypi" {
    for_each = var.pypi_package != null ? [1] : []
    content {
      package = var.pypi_package
      repo    = var.pypi_repo
    }
  }

  dynamic "whl" {
    for_each = var.whl_file != null ? [1] : []
    content {
      path = var.whl_file
    }
  }

  dynamic "jar" {
    for_each = var.jar_file != null ? [1] : []
    content {
      path = var.jar_file
    }
  }
}