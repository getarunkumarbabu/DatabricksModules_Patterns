# =============================================================================
# Databricks Role Assignment Outputs
# =============================================================================
# This file defines the outputs exposed by the role assignments.
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Group Outputs
# -----------------------------------------------------------------------------
output "admin_group_roles" {
  description = <<DESC
The roles assigned to the admin Azure AD group in Databricks.
This can be used to verify the admin role assignment.
DESC

  value = databricks_group_role.admin.roles
}

# -----------------------------------------------------------------------------
# User Groups Outputs
# -----------------------------------------------------------------------------
output "user_group_roles" {
  description = <<DESC
Map of user group names to their assigned roles in Databricks.
This can be used to verify user role assignments.
DESC

  value = {
    for name, group in databricks_group_role.users : name => group.roles
  }
}

output "user_group_sql_permissions" {
  description = <<DESC
Map of user group names to their SQL permissions in Databricks.
This can be used to verify SQL access assignments.
DESC

  value = {
    for name, perms in databricks_sql_permissions.user_groups : name => perms.privileges
  }
}