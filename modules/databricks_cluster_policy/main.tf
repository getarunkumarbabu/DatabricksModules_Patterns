resource "databricks_cluster_policy" "this" {
  name       = var.name
  definition = var.definition

  dynamic "policy_family_definition_overrides" {
    for_each = var.policy_family_id != null ? [1] : []
    content {
      policy_family_id = var.policy_family_id
      overrides       = var.policy_family_overrides
    }
  }
}