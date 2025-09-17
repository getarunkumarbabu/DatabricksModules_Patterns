# Databricks Permissions Module

This module manages permissions using the `databricks_permissions` resource.

## Inputs

- `cluster_policy_id` (string, optional) - Cluster policy ID
- `instance_pool_id` (string, optional) - Instance pool ID
- `job_id` (string, optional) - Job ID
- `notebook_path` (string, optional) - Notebook path
- `access_controls` (list) - Access control rules:
  - permission_level
  - user_name (optional)
  - group_name (optional)
  - service_principal_name (optional)

## Outputs

- `object_type` - Type of object
- `object_id` - Object ID

## Example

```hcl
module "notebook_permissions" {
  source = "../modules/databricks_permissions"
  
  notebook_path = "/Shared/MyNotebook"
  
  access_controls = [
    {
      permission_level = "CAN_RUN"
      group_name      = "data-scientists"
    },
    {
      permission_level = "CAN_MANAGE"
      user_name       = "admin@example.com"
    }
  ]
}
```

## Permission Levels

Common permission levels:
- Notebooks: CAN_READ, CAN_RUN, CAN_EDIT, CAN_MANAGE
- Jobs: CAN_VIEW, CAN_MANAGE
- Clusters: CAN_ATTACH_TO, CAN_RESTART, CAN_MANAGE
- Instance Pools: CAN_ATTACH_TO, CAN_MANAGE

## Notes

- Only one object ID should be specified
- Permission levels vary by object type
- Consider using groups for easier management
- Service principals useful for automation
- Some objects inherit workspace-level permissions