# =============================================================================
# Databricks Role Assignments
# =============================================================================
# This configuration assigns roles to existing Azure AD groups in Databricks.
# All groups must already exist in Azure AD.
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Role Assignment
# -----------------------------------------------------------------------------
resource "databricks_group_role" "admin" {
  # Reference the existing Azure AD admin group
  display_name = var.existing_admin_group_name

  # Assign admin role to the group
  # Note: Admin role automatically includes workspace access
  roles = ["admin"]
}

# -----------------------------------------------------------------------------
# User Role and Workspace Access
# -----------------------------------------------------------------------------
resource "databricks_group_role" "users" {
  # Create a role assignment for each user group
  for_each = toset(var.existing_user_group_names)

  # Reference the existing Azure AD group
  display_name = each.value

  # Assign user role
  roles = ["user"]

  # Enable workspace access for the group
  workspace_access = true
}

