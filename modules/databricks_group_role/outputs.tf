# =============================================================================
# Databricks Group Role Assignment Outputs
# =============================================================================

# ------------------------------------------------------------------------------
# Group Information
# ------------------------------------------------------------------------------
output "group_id" {
  description = "ID of the Databricks group"
  value       = local.group_id
}

output "group_name" {
  description = "Display name of the Databricks group"
  value       = local.group_name_ref
}

output "external_id" {
  description = "External ID of the group (if managed externally)"
  value       = local.external_id_ref
}

# ------------------------------------------------------------------------------
# Access Permissions
# ------------------------------------------------------------------------------
output "workspace_access" {
  description = "Whether the group has workspace access"
  value       = var.workspace_access
}

output "allow_cluster_create" {
  description = "Whether the group can create clusters (only applicable for newly created groups)"
  value       = var.external_id == null ? databricks_group.this[0].allow_cluster_create : null
}

output "databricks_sql_access" {
  description = "Whether the group has Databricks SQL access (only applicable for newly created groups)"
  value       = var.external_id == null ? databricks_group.this[0].databricks_sql_access : null
}

# ------------------------------------------------------------------------------
# Role Assignments
# ------------------------------------------------------------------------------
output "assigned_roles" {
  description = "List of roles configured for the group (assignment limited by provider version)"
  value       = var.roles
}

output "roles" {
  description = "Map of role assignments with their status (note: actual assignment limited by provider version)"
  value = {
    for role in var.roles : role => "configured_but_not_assigned"
  }
}

output "role_assignment_note" {
  description = "Note about role assignment limitations"
  value       = "Role assignment is not supported in Databricks provider v0.6.2. Consider upgrading to a newer provider version for full role assignment functionality."
}

# ------------------------------------------------------------------------------
# Group Members
# ------------------------------------------------------------------------------
output "member_count" {
  description = "Number of direct members in the group"
  value       = length(var.member_user_ids)
}

output "member_user_ids" {
  description = "List of user IDs that are direct members of the group"
  value       = var.member_user_ids
}

# ------------------------------------------------------------------------------
# Group Metadata
# ------------------------------------------------------------------------------
output "group_config" {
  description = "Complete group configuration summary"
  value = {
    id                    = local.group_id
    display_name          = local.group_name_ref
    external_id           = local.external_id_ref
    workspace_access      = var.workspace_access
    allow_cluster_create  = var.external_id == null ? databricks_group.this[0].allow_cluster_create : null
    databricks_sql_access = var.external_id == null ? databricks_group.this[0].databricks_sql_access : null
    assigned_roles        = var.roles
    member_count          = length(var.member_user_ids)
    is_existing_group     = var.external_id != null
  }
}