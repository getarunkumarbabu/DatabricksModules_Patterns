# Create the service principal
resource "databricks_service_principal" "this" {
  display_name   = var.service_principal_name
  application_id = var.application_id
}

# Grant workspace access if enabled
resource "databricks_workspace_access" "this" {
  count             = var.workspace_access ? 1 : 0
  service_principal = databricks_service_principal.this.id
}

# Assign roles to the service principal
resource "databricks_service_principal_role" "this" {
  for_each = toset(var.roles)

  service_principal_id = databricks_service_principal.this.id
  role                 = each.value

  depends_on = [
    databricks_workspace_access.this
  ]
}