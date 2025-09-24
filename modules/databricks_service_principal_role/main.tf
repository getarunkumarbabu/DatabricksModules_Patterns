terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_service_principal" "this" {
  application_id = var.application_id
  display_name   = var.display_name
}

# ------------------------------------------------------------------------------
# Service Principal Role Assignment (Available in v1.90.0)
# ------------------------------------------------------------------------------
# NOTE: databricks_service_principal_role resource may need verification
# Uncomment when the correct role assignment method is determined
# resource "databricks_service_principal_role" "this" {
#   for_each = toset(var.roles)
#
#   service_principal_id = databricks_service_principal.this.id
#   role                 = each.value
# }