# Create the group
resource "databricks_group" "this" {
  display_name = var.group_name
}

# Grant workspace access if enabled
resource "databricks_workspace_access" "this" {
  count = var.workspace_access ? 1 : 0
  group = databricks_group.this.id
}

# Assign roles to the group
resource "databricks_group_role" "this" {
  for_each = toset(var.roles)

  group_id = databricks_group.this.id
  role     = each.value

  depends_on = [
    databricks_workspace_access.this
  ]
}