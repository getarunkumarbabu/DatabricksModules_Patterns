# =============================================================================
# Unified Databricks Group Role Assignment Outputs
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Groups Output
# -----------------------------------------------------------------------------
output "admin_groups_config" {
  description = "Admin groups configuration and role assignments"
  value = {
    for name, group in module.admin_groups : name => {
      id               = group.group_id
      roles            = group.assigned_roles
      display_name     = name
      workspace_access = group.workspace_access
      cluster_create   = group.allow_cluster_create
      sql_access       = group.databricks_sql_access
    }
  }
}

# -----------------------------------------------------------------------------
# User Groups Output
# -----------------------------------------------------------------------------
output "user_groups_config" {
  description = "User groups configuration and role assignments"
  value = {
    for name, group in module.user_groups : name => {
      id               = group.group_id
      roles            = group.assigned_roles
      display_name     = name
      workspace_access = group.workspace_access
      cluster_create   = group.allow_cluster_create
      sql_access       = group.databricks_sql_access
    }
  }
}

# -----------------------------------------------------------------------------
# Combined Information
# -----------------------------------------------------------------------------
output "all_group_assignments" {
  description = "Combined group role assignments"
  value = {
    admin_groups = local.admin_group_summary
    user_groups  = local.user_group_summary
  }
}

output "all_group_ids" {
  description = "Map of all group IDs for easy reference"
  value       = local.all_group_ids
}

output "group_roles_summary" {
  description = "Map of all groups to their assigned roles"
  value       = local.group_roles
}

# -----------------------------------------------------------------------------
# Summary Statistics
# -----------------------------------------------------------------------------
output "group_counts" {
  description = "Summary of group counts by type"
  value = {
    admin_groups = length(var.admin_groups)
    user_groups  = length(var.user_groups)
    total_groups = length(var.admin_groups) + length(var.user_groups)
  }
}

output "permission_summary" {
  description = "Summary of permissions across all groups"
  value = {
    groups_with_cluster_create = length([
      for g in concat(values(local.admin_group_summary), values(local.user_group_summary))
      : g if g.cluster_create == true
    ])
    groups_with_sql_access = length([
      for g in concat(values(local.admin_group_summary), values(local.user_group_summary))
      : g if g.sql_access == true
    ])
    groups_with_workspace_access = length([
      for g in concat(values(local.admin_group_summary), values(local.user_group_summary))
      : g if g.workspace_access == true
    ])
  }
}