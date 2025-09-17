resource "databricks_provider" "this" {
  name                = var.name
  comment             = var.comment
  recipient_profile_str = var.recipient_profile_str
  authentication_type = var.authentication_type

  delta_sharing_scope {
    scope = try(var.delta_sharing_scope.scope, null)
  }

  delta_sharing_authentication {
    token = var.authentication_type == "TOKEN" ? var.token : null
  }
}