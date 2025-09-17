# Databricks Group Module

Creates a `databricks_group` and optionally adds members.

Inputs
- `display_name` (string) - group name
- `members` (list(string), optional) - member ids to add

Outputs
- `group_id`

Example
```
module "group" {
  source = "../modules/databricks_group"
  display_name = "data-scientists"
  members = ["user1@example.com", "user2@example.com"]
}
```
