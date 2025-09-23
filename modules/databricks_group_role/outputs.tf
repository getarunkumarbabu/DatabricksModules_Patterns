# =============================================================================
# Databricks Group Role Assignment Outputs
# =============================================================================

# ------------------------------------------------------------------------------
# Group Information
# ------------------------------------------------------------------------------
output "group_id" {
  description = "ID of the Databricks group"
  value       = databricks_group.this.id
}

output "group_name" {
  description = "Display name of the Databricks group"
  value       = databricks_group.this.display_name
}

output "external_id" {
  description = "External ID of the group (if managed externally)"
  value       = databricks_group.this.external_id
}

# ------------------------------------------------------------------------------
# Access Permissions
# ------------------------------------------------------------------------------
output "workspace_access" {
  description = "Whether the group has workspace access"
  value       = var.workspace_access
}

output "allow_cluster_create" {
  description = "Whether the group can create clusters"
  value       = databricks_group.this.allow_cluster_create
}

output "databricks_sql_access" {
  description = "Whether the group has Databricks SQL access"
  value       = databricks_group.this.databricks_sql_access
}

# ------------------------------------------------------------------------------
# Role Assignments
# ------------------------------------------------------------------------------
output "assigned_roles" {
  description = "List of roles assigned to the group"
  value       = var.roles
}

output "roles" {
  description = "Map of role assignments with their status"
  value = {
    for role in var.roles : role => true
  }
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
    id                    = databricks_group.this.id
    display_name          = databricks_group.this.display_name
    external_id           = databricks_group.this.external_id
    workspace_access      = var.workspace_access
    allow_cluster_create  = databricks_group.this.allow_cluster_create
    databricks_sql_access = databricks_group.this.databricks_sql_access
    assigned_roles        = var.roles
    member_count          = length(var.member_user_ids)
  }
}