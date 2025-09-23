# =============================================================================
# Databricks Role Assignment Outputs
# =============================================================================
# This file defines the outputs exposed by the role assignments.
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Groups Outputs
# -----------------------------------------------------------------------------
output "admin_groups" {
  description = <<DESC
Map of admin group names to their configuration details including:
- Group ID
- Assigned roles
- Display name
DESC

  value = {
    for name, group in module.admin_groups : name => {
      group_id     = group.group_id
      roles        = group.roles
      display_name = group.display_name
    }
  }
}

# -----------------------------------------------------------------------------
# User Groups Outputs
# -----------------------------------------------------------------------------
output "user_groups" {
  description = <<DESC
Map of user group names to their configuration details including:
- Group ID
- Assigned roles
- Display name
- Workspace access status
DESC

  value = {
    for name, group in module.user_groups : name => {
      group_id         = group.group_id
      roles            = group.roles
      display_name     = group.display_name
      workspace_access = group.workspace_access
    }
  }
}

# -----------------------------------------------------------------------------
# Combined Group Information
# -----------------------------------------------------------------------------
output "all_groups" {
  description = "Map of all group IDs for easy reference"
  value       = local.all_group_ids
}

output "group_roles" {
  description = "Map of all groups to their assigned roles"
  value       = local.group_roles
}