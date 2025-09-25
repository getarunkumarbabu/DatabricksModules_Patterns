# Databricks Azure AD Group Module

This module creates or adds Azure AD groups to a Databricks workspace with proper permissions based on role assignment.

## Features

- **Azure AD Integration**: Links workspace groups to Azure AD via external_id (Object ID)
- **Role-Based Permissions**: Different permissions for admin vs user groups
- **Account-Level SCIM Support**: Works with groups synced from Azure AD at account level
- **Validation**: Ensures external_id is a valid UUID format

## Usage

```hcl
module "azure_ad_group" {
  source = "./modules/databricks_azure_ad_group"
  
  group_display_name = "MyAzureADGroup"
  group_external_id  = "12345678-1234-1234-1234-123456789abc"
  role              = "admin"  # or "user"
  workspace_access  = true
}
```

## Requirements

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| group_display_name | The display name of the Azure AD group | `string` | n/a | yes |
| group_external_id | The external ID of the Azure AD group (Azure AD Object ID) | `string` | n/a | yes |
| role | The role to assign to the group (admin or user) | `string` | n/a | yes |
| workspace_access | Whether to grant workspace access to the group | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| group_id | The ID of the Azure AD group in Databricks |
| group_display_name | The display name of the Azure AD group |
| group_external_id | The external ID of the Azure AD group |
| assigned_role | The role assigned to the group |
| workspace_access_granted | Whether workspace access was granted |
| permission_summary | Summary of all permissions assigned |

## Permissions by Role

### Admin Groups
- `allow_cluster_create = true`
- `allow_instance_pool_create = true`
- `workspace_access = true`

### User Groups
- `allow_cluster_create = false`
- `allow_instance_pool_create = false`
- `workspace_access = true`

## Azure AD Integration

This module works with Azure AD groups synced via SCIM at the account level:

1. **Group Creation**: Creates a workspace group with the Azure AD external_id
2. **SCIM Sync**: Databricks automatically syncs members from Azure AD
3. **Permission Assignment**: Applies role-based permissions to the group

## Example with Real Groups

```hcl
# Admin group
module "platform_admins" {
  source = "./modules/databricks_azure_ad_group"
  
  group_display_name = "Platform-Administrators"
  group_external_id  = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
  role              = "admin"
  workspace_access  = true
}

# User group
module "data_scientists" {
  source = "./modules/databricks_azure_ad_group"
  
  group_display_name = "Data-Scientists"
  group_external_id  = "b2c3d4e5-f6a7-8901-bcde-f23456789012"
  role              = "user"
  workspace_access  = true
}
```