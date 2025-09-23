# =============================================================================
# Databricks Group Role Assignment Module
# =============================================================================
# This module creates a Databricks group and assigns roles to it.
# Enhanced for Azure AD integration with comprehensive access controls.
# =============================================================================

# ------------------------------------------------------------------------------
# Databricks Group Resource
# ------------------------------------------------------------------------------
resource "databricks_group" "this" {
  display_name = var.group_name

  # Azure AD integration - external ID for existing Azure AD groups
  external_id = var.external_id

  # Access permissions
  allow_cluster_create  = var.allow_cluster_create
  databricks_sql_access = var.databricks_sql_access

  # Force delete group even if it has members (use with caution)
  force = var.force_delete_group

  # Lifecycle management
  lifecycle {
    ignore_changes = [
      # Ignore changes to external_id as it's managed by Azure AD
      external_id,
    ]
  }
}

# ------------------------------------------------------------------------------
# Workspace Access (Legacy - kept for backward compatibility)
# ------------------------------------------------------------------------------
resource "databricks_workspace_access" "this" {
  count = var.workspace_access ? 1 : 0
  group = databricks_group.this.id
}

# ------------------------------------------------------------------------------
# Role Assignments
# ------------------------------------------------------------------------------
resource "databricks_group_role" "this" {
  for_each = toset(var.roles)

  group_id = databricks_group.this.id
  role     = each.value

  depends_on = [
    databricks_workspace_access.this
  ]
}

# ------------------------------------------------------------------------------
# Group Members (Optional - for direct member management)
# ------------------------------------------------------------------------------
resource "databricks_group_member" "this" {
  for_each = toset(var.member_user_ids)

  group_id  = databricks_group.this.id
  member_id = each.value

  depends_on = [
    databricks_group.this
  ]
}