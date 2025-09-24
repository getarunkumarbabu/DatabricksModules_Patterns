# =============================================================================
# Databricks Group Role Assignment Module
# =============================================================================
# This module manages Databricks groups and assigns roles to them.
# Supports both existing SCIM-synced Azure AD groups and newly created groups.
# Enhanced for Azure AD integration with comprehensive access controls.
#
# NOTE: Role assignment is limited in Databricks provider v0.6.2
# For full role assignment functionality, consider upgrading to a newer provider version.
# =============================================================================

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

# ------------------------------------------------------------------------------
# Existing Databricks Group Data Source (for SCIM-synced Azure AD groups)
# ------------------------------------------------------------------------------
data "databricks_group" "existing" {
  count = var.external_id != null ? 1 : 0

  # For SCIM-synced groups, use both display_name and external_id
  display_name = var.group_name
  external_id  = var.external_id
}

# ------------------------------------------------------------------------------
# Databricks Group Resource (only create if not using existing group)
# ------------------------------------------------------------------------------
resource "databricks_group" "this" {
  count = var.external_id == null ? 1 : 0

  display_name = var.group_name

  # No external_id for newly created groups
  # external_id = var.external_id

  # Lifecycle management
  lifecycle {
    ignore_changes = [
      # Ignore changes to external_id as it's managed by Azure AD
      external_id,
    ]
  }
}

# ------------------------------------------------------------------------------
# Local values for unified group reference
# ------------------------------------------------------------------------------
locals {
  # Use existing group if available, otherwise use created group
  group_id       = var.external_id != null ? data.databricks_group.existing[0].id : databricks_group.this[0].id
  group_name_ref = var.external_id != null ? data.databricks_group.existing[0].display_name : databricks_group.this[0].display_name
  external_id_ref = var.external_id != null ? data.databricks_group.existing[0].external_id : null
}

# ------------------------------------------------------------------------------
# Role Assignments (Commented out - not supported in older provider version)
# ------------------------------------------------------------------------------
# Note: databricks_group_role is not available in Databricks provider v0.6.2
# In older versions, roles were assigned differently or through permissions
# resource "databricks_group_role" "this" {
#   for_each = toset(var.roles)
# 
#   group_id = databricks_group.this.id
#   role     = each.value
# 
#   depends_on = [
#     databricks_group.this
#   ]
# }



resource "databricks_group_member" "this" {
  count = var.external_id == null ? length(var.member_user_ids) : 0

  group_id  = local.group_id
  member_id = var.member_user_ids[count.index]
}