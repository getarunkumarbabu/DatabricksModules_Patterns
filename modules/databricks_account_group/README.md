# Databricks Account Group Module

This module creates a Databricks account-level group and optionally adds members to it.

## Usage

```hcl
module "account_group" {
  source = "../../modules/databricks_account_group"

  display_name = "My Account Group"
  account_id   = "1234567890123456"
  members      = ["user1@example.com", "user2@example.com"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Group display name | `string` | n/a | yes |
| account_id | Databricks account ID | `string` | n/a | yes |
| members | Optional list of member IDs to add to the group | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_id | The ID of the created group |
| display_name | The display name of the group |