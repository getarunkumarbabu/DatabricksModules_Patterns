# =============================================================================
# Databricks Group Role Assignment Module
# =============================================================================
# This module creates Databricks groups and assigns roles to them.
# Supports both existing SCIM-synced Azure AD groups and newly created groups.
# Enhanced for Azure AD integration with comprehensive access controls.
#
# NOTE: Using Databricks provider v1.90.0 with full feature support
# Role assignment functionality is now available with databricks_group_role resource
# =============================================================================

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

# ------------------------------------------------------------------------------
# Databricks Group Resource (create new or reference existing SCIM group)
# ------------------------------------------------------------------------------
resource "databricks_group" "this" {
  display_name               = var.group_name
  external_id                = var.external_id # Include external_id if provided (for SCIM groups)
  allow_cluster_create       = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  databricks_sql_access      = var.databricks_sql_access
  workspace_access           = var.workspace_access

  # Lifecycle management
  lifecycle {
    ignore_changes = [
      # Ignore changes to external_id as it's managed by Azure AD
      external_id,
    ]
  }
}

# ------------------------------------------------------------------------------
# Databricks Group Member Management
# ------------------------------------------------------------------------------
resource "databricks_group_member" "this" {
  for_each = toset(var.member_user_ids)

  group_id  = databricks_group.this.id
  member_id = each.value
}


resource "databricks_group_role" "this" {
  for_each = toset(var.roles)

  group_id = databricks_group.this.id
  role     = each.value

  depends_on = [
    databricks_group.this
  ]
}