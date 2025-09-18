# Create the user
resource "databricks_user" "this" {
  user_name    = var.user_name
  display_name = var.display_name
}

# Grant workspace access if enabled
resource "databricks_workspace_access" "this" {
  count = var.workspace_access ? 1 : 0
  user  = databricks_user.this.id
}

# Assign roles to the user
resource "databricks_user_role" "this" {
  for_each = toset(var.roles)

  user_id = databricks_user.this.id
  role    = each.value

  depends_on = [
    databricks_workspace_access.this
  ]
}