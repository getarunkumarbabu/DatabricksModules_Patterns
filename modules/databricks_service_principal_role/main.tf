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

# Service principal role assignment now supported in v1.90.0
# resource "databricks_service_principal_role" "this" {
#   for_each = toset(var.roles)
# 
#   service_principal_id = databricks_service_principal.this.id
#   role                 = each.value
# }