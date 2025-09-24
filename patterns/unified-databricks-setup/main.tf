# =============================================================================
# Unified Databricks Group Role Assignment Pattern
# =============================================================================
# This pattern manages Azure AD group role assignments in Databricks workspaces.
# Supports both admin and user groups with customizable roles and access levels.
# =============================================================================

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.90.0"
    }
  }

  # Optional: Configure backend for state management
  # backend "azurerm" {
  #   resource_group_name  = var.resource_group_name
  #   storage_account_name = var.storage_account_name
  #   container_name       = var.container_name
  #   key                  = var.key
  # }
}

# -----------------------------------------------------------------------------
# Databricks Provider Configuration
# -----------------------------------------------------------------------------
provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

# -----------------------------------------------------------------------------
# Admin Groups Role Assignment
# -----------------------------------------------------------------------------
module "admin_groups" {
  source = "../../modules/databricks_group_role"

  for_each = { for group in var.admin_groups : group.display_name => group }

  group_name  = each.value.display_name
  external_id = lookup(each.value, "external_id", null)
  roles       = [] # Temporarily disable role assignment while testing
}

# -----------------------------------------------------------------------------
# User Groups Role Assignment
# -----------------------------------------------------------------------------
module "user_groups" {
  source = "../../modules/databricks_group_role"

  for_each = { for group in var.user_groups : group.display_name => group }

  group_name            = each.value.display_name
  external_id           = lookup(each.value, "external_id", null)
  roles                 = lookup(each.value, "roles", ["user"])
  workspace_access      = lookup(each.value, "workspace_access", true)
  allow_cluster_create  = lookup(each.value, "allow_cluster_create", false)
  databricks_sql_access = lookup(each.value, "databricks_sql_access", true)
}

# -----------------------------------------------------------------------------
# Service Principals Role Assignment (Commented out - not supported in older provider version)
# -----------------------------------------------------------------------------
# module "service_principals" {
#   source = "../../modules/databricks_service_principal_role"
# 
#   for_each = { for sp in var.service_principals : sp.application_id => sp }
# 
#   application_id = each.value.application_id
#   display_name   = lookup(each.value, "display_name", null)
#   roles          = lookup(each.value, "roles", ["user"])
# }

# -----------------------------------------------------------------------------
# Account Level Groups (Commented out - not supported in older provider version)
# -----------------------------------------------------------------------------
# module "account_level_groups" {
#   source = "../../modules/databricks_account_group"
# 
#   for_each = { for group in var.account_level_groups : group.display_name => group }
# 
#   display_name = each.value.display_name
#   account_id   = var.account_id
#   members      = lookup(each.value, "members", null)
# }

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
    { for k, v in module.admin_groups : k => v.assigned_roles },
    { for k, v in module.user_groups : k => v.assigned_roles }
  )

  # Group configuration summary
  admin_group_summary = {
    for name, group in module.admin_groups : name => {
      id               = group.group_id
      roles            = group.assigned_roles
      workspace_access = group.workspace_access
      cluster_create   = group.allow_cluster_create
      sql_access       = group.databricks_sql_access
    }
  }

  user_group_summary = {
    for name, group in module.user_groups : name => {
      id               = group.group_id
      roles            = group.assigned_roles
      workspace_access = group.workspace_access
      cluster_create   = group.allow_cluster_create
      sql_access       = group.databricks_sql_access
    }
  }
}

