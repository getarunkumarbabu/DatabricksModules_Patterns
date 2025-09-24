terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_account_group" "this" {
  display_name = var.display_name
}

resource "databricks_account_group_member" "members" {
  for_each = var.members == null ? [] : var.members

  account_id = var.account_id
  group_id   = databricks_account_group.this.id
  member_id  = each.value
}