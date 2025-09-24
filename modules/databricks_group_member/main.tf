# =============================================================================
# Databricks Group Member Module
# =============================================================================
# This module manages individual group memberships in Databricks.
# =============================================================================

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_group_member" "this" {
  group_id  = var.group_id
  member_id = var.member_id
}