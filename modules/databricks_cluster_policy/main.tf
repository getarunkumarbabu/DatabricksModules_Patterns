resource "databricks_cluster_policy" "this" {
  name                = var.name
  description         = var.description
  definition          = var.definition
  max_clusters_per_user = var.max_clusters_per_user

  dynamic "policy_family_definition_overrides" {
    for_each = var.policy_family_id != null ? [1] : []
    content {
      policy_family_id = var.policy_family_id
      overrides       = var.policy_family_overrides
    }
  }

  dynamic "libraries" {
    for_each = var.libraries != null ? [1] : []
    content {
      dynamic "jar" {
        for_each = try(var.libraries.jar, [])
        content {
          path = jar.value
        }
      }
      dynamic "egg" {
        for_each = try(var.libraries.egg, [])
        content {
          path = egg.value
        }
      }
      dynamic "whl" {
        for_each = try(var.libraries.whl, [])
        content {
          path = whl.value
        }
      }
      dynamic "pypi" {
        for_each = try(var.libraries.pypi, [])
        content {
          package = pypi.value
        }
      }
      dynamic "maven" {
        for_each = try(var.libraries.maven, [])
        content {
          coordinates = maven.value.coordinates
          repo       = maven.value.repo
          exclusions = maven.value.exclusions
        }
      }
      dynamic "cran" {
        for_each = try(var.libraries.cran, [])
        content {
          package = cran.value
        }
      }
    }
  }
}