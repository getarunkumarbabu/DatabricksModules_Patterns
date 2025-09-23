# =============================================================================
# Databricks Role Assignments Pattern
# =============================================================================
# This pattern assigns roles to existing Azure AD groups in Databricks.
# Features:
# - Multiple admin groups support
# - Multiple user groups with customizable roles
# - Workspace access management
# - All groups must already exist in Azure AD
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Groups Role Assignment
# -----------------------------------------------------------------------------
module "admin_groups" {
  source = "../../modules/databricks_group_role"

  for_each = { for group in var.admin_groups : group.display_name => group }

  # Group configuration
  group_name = each.value.display_name

  # Admin role assignment
  roles = concat(["admin"], each.value.additional_roles)

  # Optional workspace access (enabled by default for admin)
  workspace_access = true
}

# -----------------------------------------------------------------------------
# User Groups Role Assignment
# -----------------------------------------------------------------------------
module "user_groups" {
  source = "../../modules/databricks_group_role"

  for_each = { for group in var.user_groups : group.display_name => group }

  # Group configuration
  group_name = each.value.display_name

  # Assign configured roles (defaults to ["user"] if not specified)
  roles = each.value.roles

  # Workspace access based on group configuration
  workspace_access = each.value.workspace_access
}

# -----------------------------------------------------------------------------
# Workspace Group Organization
# -----------------------------------------------------------------------------
locals {
  # Flatten all group IDs for easy reference
  all_group_ids = merge(
    { for k, v in module.admin_groups : k => v.group_id },
    { for k, v in module.user_groups : k => v.group_id }
  )

  # Map groups to their assigned roles for validation
  group_roles = merge(
    { for k, v in module.admin_groups : k => v.roles },
    { for k, v in module.user_groups : k => v.roles }
  )
}

