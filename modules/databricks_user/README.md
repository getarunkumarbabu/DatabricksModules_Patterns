# Databricks User Module

This module manages users using the `databricks_user` resource.

## Inputs

- `user_name` (string) - User name (email)
- `display_name` (string) - Display name
- `active` (bool, optional) - Active state
- `force` (bool, optional) - Force creation

## Outputs

- `user_id` - User ID
- `user_name` - User name
- `home` - Home directory

## Example

```hcl
module "data_scientist" {
  source = "../modules/databricks_user"
  
  user_name    = "analyst@example.com"
  display_name = "Data Analyst"
  active       = true
}
```

## Notes

- Users are typically managed through SSO
- Each user gets a personal workspace
- Consider group memberships for access control
- Active state controls login ability
- Force creation helpful for import scenarios