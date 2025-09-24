# ------------------------------------------------------------------------------
# Group Information
# ------------------------------------------------------------------------------
output "group_id" {
  description = "Databricks group ID"
  value       = databricks_group.this.id
}

output "group_name" {
  description = "Group display name"
  value       = databricks_group.this.display_name
}

output "external_id" {
  description = "External ID (Azure AD)"
  value       = databricks_group.this.external_id
}

# ------------------------------------------------------------------------------
# Access Permissions
# ------------------------------------------------------------------------------
output "workspace_access" {
  description = "Workspace access status"
  value       = var.workspace_access
}

output "allow_cluster_create" {
  description = "Cluster creation permission"
  value       = databricks_group.this.allow_cluster_create
}

output "allow_instance_pool_create" {
  description = "Instance pool creation permission"
  value       = databricks_group.this.allow_instance_pool_create
}

output "databricks_sql_access" {
  description = "SQL access status"
  value       = databricks_group.this.databricks_sql_access
}

# ------------------------------------------------------------------------------
# Role and Member Information
# ------------------------------------------------------------------------------
output "assigned_roles" {
  description = "List of roles configured for the group"
  value       = var.roles
}

output "roles" {
  description = "Role assignment map"
  value = {
    for role in var.roles : role => true
  }
}

output "member_count" {
  description = "Number of direct members"
  value       = length(var.member_user_ids)
}

# ------------------------------------------------------------------------------
# Group Configuration Summary
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
    is_existing_group     = var.external_id != null
  }
}