# Databricks Service Principal Module

This module manages service principals using the `databricks_service_principal` resource.

## Inputs

- `display_name` (string) - Display name
- `allow_cluster_create` (bool, optional) - Allow cluster creation
- `allow_instance_pool_create` (bool, optional) - Allow pool creation
- `force` (bool, optional) - Force creation
- `active` (bool, optional) - Active state

## Outputs

- `service_principal_id` - Service principal ID
- `application_id` - Application ID
- `display_name` - Display name

## Example

```hcl
module "service_principal" {
  source = "../modules/databricks_service_principal"
  
  display_name = "cicd-automation"
  
  allow_cluster_create       = true
  allow_instance_pool_create = true
  active                    = true
}
```

## Notes

- Service principals are useful for automation
- Consider security implications when granting permissions
- Use with Databricks tokens or OAuth for authentication
- Can be integrated with Azure AD service principals
- Best practice: limit permissions to required resources