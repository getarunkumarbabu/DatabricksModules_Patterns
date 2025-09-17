# Databricks Group Member Module

This module manages group memberships in Databricks, allowing you to add users and service principals to groups.

## Features

- Add users to groups
- Add service principals to groups
- Manage group memberships through infrastructure as code

## Usage

```hcl
module "group_member" {
  source = "./modules/databricks_group_member"

  group_id  = "123456789"  # Group ID
  member_id = "987654321"  # User or Service Principal ID
}
```

## Examples

### Add User to Group

```hcl
module "user_group_member" {
  source = "./modules/databricks_group_member"

  group_id  = databricks_group.data_scientists.id
  member_id = databricks_user.john_doe.id
}
```

### Add Service Principal to Group

```hcl
module "sp_group_member" {
  source = "./modules/databricks_group_member"

  group_id  = databricks_group.admins.id
  member_id = databricks_service_principal.automation.id
}
```

## Requirements

- Databricks provider configured with workspace access
- Appropriate permissions to manage groups and memberships

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| group_id | The ID of the group to add the member to | `string` | n/a | yes |
| member_id | The ID of the user or service principal to add to the group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| group_member_id | The unique identifier for the group membership |
| group_id | The ID of the group |
| member_id | The ID of the member |

## Notes

1. Group memberships are workspace-specific.
2. Users and service principals must exist before being added to groups.
3. A member can belong to multiple groups.
4. Removing the group membership will not delete the user or service principal.

## Best Practices

1. Use clear naming conventions for groups
2. Document group purposes and access levels
3. Regularly audit group memberships
4. Implement principle of least privilege
5. Consider using group hierarchies for access management