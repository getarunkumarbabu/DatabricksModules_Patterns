resource "databricks_group" "this" {
  display_name = var.display_name
}

resource "databricks_group_member" "members" {
  for_each = var.members == null ? [] : var.members

  group_id = databricks_group.this.id
  member_id = each.value
}
