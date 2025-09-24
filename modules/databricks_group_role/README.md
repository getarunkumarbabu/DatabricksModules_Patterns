# Databricks Group Role Assignment Module

This module creates and manages Databricks groups with comprehensive role assignments and access controls. Enhanced for Azure AD integration with advanced permissions management.

## Features

- **Azure AD Integration**: Support for external groups via `external_id`
- **Granular Access Control**: Fine-tuned permissions for clusters, instance pools, and SQL access
- **Role-Based Access**: Multiple workspace-level roles assignment using `databricks_group_role` resource (under investigation)
- **Direct Member Management**: Optional direct user membership management
- **Flexible Configuration**: Comprehensive variable options for different use cases

## Requirements

- **Databricks Provider**: `>= 1.0.0` (tested with v1.90.0)
- **Terraform**: `>= 1.0`

## Usage

### Basic Usage

```hcl
module "databricks_group" {
  source = "./modules/databricks_group_role"

  group_name = "data-scientists"
  roles      = ["user", "notebook_admin"]

  # Access permissions
  allow_cluster_create = true
  databricks_sql_access = true
}
```

### Azure AD Integration

```hcl
module "azure_ad_group" {
  source = "./modules/databricks_group_role"

  group_name  = "azure-data-engineers"
  external_id = "12345678-1234-1234-1234-123456789012"  # Azure AD Group Object ID

  roles = ["user", "cluster_admin", "job_admin"]

  # Advanced permissions
  allow_cluster_create       = true
  allow_instance_pool_create = true
  databricks_sql_access      = true
}
```

  source = "./modules/databricks_group_role"  group_name  = "existing-data-engineers"

  external_id = "87654321-4321-4321-4321-210987654321"  # Azure AD Group Object ID

  group_name = "managed-users"

  # Roles will be assigned to the existing group

  roles = ["user"]  roles = ["user", "cluster_admin"]



  # Direct member management  # Permissions can still be configured

  member_user_ids = [  allow_cluster_create  = true

    "user1@example.com",  databricks_sql_access = true

    "user2@example.com"}

  ]```

}

```### With Direct Member Management



## Requirements```hcl

module "managed_group" {

| Name | Version |  source = "./modules/databricks_group_role"

|------|---------|

| terraform | >= 1.0.0 |  group_name = "managed-users"

| databricks | >= 1.0.0 |

  roles = ["user"]

## Providers

  # Direct member management

| Name | Version |  member_user_ids = [

|------|---------|    "user1@example.com",

| databricks | >= 1.0.0 |    "user2@example.com"

  ]

## Input Variables}

```

### Group Configuration

## Requirements

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|:--------:|| Name | Version |

| group_name | Display name of the Databricks group | `string` | n/a | yes ||------|---------|

| external_id | External ID for Azure AD integration | `string` | `null` | no || terraform | >= 1.0.0 |

| databricks | >= 1.0.0 |

### Access Permissions

## Providers

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|:--------:|| Name | Version |

| workspace_access | Grant workspace access (legacy) | `bool` | `true` | no ||------|---------|

| allow_cluster_create | Allow cluster creation | `bool` | `false` | no || databricks | >= 1.0.0 |

| databricks_sql_access | Grant Databricks SQL access | `bool` | `false` | no |

## Input Variables

### Role Assignments

### Group Configuration

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|:--------:|| Name | Description | Type | Default | Required |

| roles | List of roles to assign | `list(string)` | `[]` | no ||------|-------------|------|---------|:--------:|

| group_name | Display name of the Databricks group | `string` | n/a | yes |

**Valid Roles:**| external_id | External ID for Azure AD integration | `string` | `null` | no |

- `admin` - Full administrative access

- `user` - Basic user access### Access Permissions

- `account_admin` - Account-level administration

- `cluster_admin` - Cluster management| Name | Description | Type | Default | Required |

- `workspace_admin` - Workspace administration|------|-------------|------|---------|:--------:|

- `token_admin` - Token management| workspace_access | Grant workspace access (legacy) | `bool` | `true` | no |

- `notebook_admin` - Notebook administration| allow_cluster_create | Allow cluster creation | `bool` | `false` | no |

- `sql_admin` - SQL administration| databricks_sql_access | Grant Databricks SQL access | `bool` | `false` | no |

- `job_admin` - Job management

- `mlflow_admin` - MLflow administration### Role Assignments

- `feature_store_admin` - Feature Store administration

| Name | Description | Type | Default | Required |

### Member Management|------|-------------|------|---------|:--------:|

| roles | List of roles to assign | `list(string)` | `[]` | no |

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|:--------:|**Valid Roles:**

| member_user_ids | Direct user members | `list(string)` | `[]` | no |- `admin` - Full administrative access

- `user` - Basic user access

### Lifecycle Management- `account_admin` - Account-level administration

- `cluster_admin` - Cluster management

| Name | Description | Type | Default | Required |- `workspace_admin` - Workspace administration

|------|-------------|------|---------|:--------:|- `token_admin` - Token management

| force_delete_group | Force delete with members | `bool` | `false` | no |- `notebook_admin` - Notebook administration

- `sql_admin` - SQL administration

## Outputs- `job_admin` - Job management

- `mlflow_admin` - MLflow administration

### Group Information- `feature_store_admin` - Feature Store administration



| Name | Description |### Member Management

|------|-------------|

| group_id | Databricks group ID || Name | Description | Type | Default | Required |

| group_name | Group display name ||------|-------------|------|---------|:--------:|

| external_id | External ID (Azure AD) || member_user_ids | Direct user members | `list(string)` | `[]` | no |



### Access Permissions### Lifecycle Management



| Name | Description || Name | Description | Type | Default | Required |

|------|-------------||------|-------------|------|---------|:--------:|

| workspace_access | Workspace access status || force_delete_group | Force delete with members | `bool` | `false` | no |

| allow_cluster_create | Cluster creation permission |

| databricks_sql_access | SQL access status |## Outputs



### Role and Member Information### Group Information



| Name | Description || Name | Description |

|------|-------------||------|-------------|

| assigned_roles | List of assigned roles || group_id | Databricks group ID |

| roles | Role assignment map || group_name | Group display name |

| member_count | Number of direct members || external_id | External ID (Azure AD) |

| group_config | Complete group configuration summary |

### Access Permissions

## Notes

| Name | Description |

- **Role Assignment Limitation**: In Databricks provider v0.6.2, role assignment resources (`databricks_group_role`) are not available. Roles are configured but actual assignment may require manual steps or provider upgrades.|------|-------------|

- **SCIM Integration**: When `external_id` is provided, the group will be linked to the corresponding Azure AD group for automatic membership synchronization.| workspace_access | Workspace access status |

- **Permission Management**: Access permissions are set at the group level and apply to all group members.| allow_cluster_create | Cluster creation permission |
| databricks_sql_access | SQL access status |

### Role and Member Information

| Name | Description |
|------|-------------|
| assigned_roles | List of assigned roles |
| roles | Role assignment map |
| member_count | Number of direct members |
| member_user_ids | Direct member user IDs |

### Complete Configuration

| Name | Description |
|------|-------------|
| group_config | Complete group configuration summary |

## Examples

### Multi-Group Setup with Azure AD

```hcl
# Admin Groups
module "admin_groups" {
  for_each = {
    super_admins = {
      name       = "super-admins"
      external_id = "11111111-1111-1111-1111-111111111111"
      roles      = ["admin", "account_admin"]
      allow_cluster_create = true
    }
    workspace_admins = {
      name       = "workspace-admins"
      external_id = "22222222-2222-2222-2222-222222222222"
      roles      = ["workspace_admin", "token_admin"]
      allow_cluster_create = true
    }
  }

  source = "./modules/databricks_group_role"

  group_name  = each.value.name
  external_id = each.value.external_id
  roles       = each.value.roles

  allow_cluster_create = each.value.allow_cluster_create
}

# User Groups
module "user_groups" {
  for_each = {
    data_scientists = {
      name       = "data-scientists"
      external_id = "33333333-3333-3333-3333-333333333333"
      roles      = ["user", "notebook_admin"]
      sql_access = true
    }
    data_engineers = {
      name       = "data-engineers"
      external_id = "44444444-4444-4444-4444-444444444444"
      roles      = ["user", "cluster_admin", "job_admin"]
      cluster_create = true
      sql_access     = true
    }
  }

  source = "./modules/databricks_group_role"

  group_name  = each.value.name
  external_id = each.value.external_id
  roles       = each.value.roles

  allow_cluster_create  = lookup(each.value, "cluster_create", false)
  databricks_sql_access = lookup(each.value, "sql_access", false)
}
```

### Direct Member Management

```hcl
module "direct_members_group" {
  source = "./modules/databricks_group_role"

  group_name = "special-users"

  roles = ["user", "sql_admin"]

  member_user_ids = [
    "alice@example.com",
    "bob@example.com",
    "charlie@example.com"
  ]

  databricks_sql_access = true
}
```

## Azure AD Integration Notes

1. **External ID**: Use the Azure AD Group Object ID as the `external_id`
2. **SCIM Sync**: Ensure Azure AD SCIM provisioning is configured
3. **Group Management**: Groups are typically managed in Azure AD, not Terraform
4. **Member Sync**: Members are synchronized automatically via SCIM

## Best Practices

### Security
- Use principle of least privilege
- Regularly audit group memberships
- Implement proper role separation
- Monitor access patterns

### Azure Integration
- Use external_id for Azure AD groups
- Configure SCIM provisioning
- Maintain group management in Azure AD
- Use descriptive group names

### Configuration Management
- Use consistent naming conventions
- Document role assignments
- Version control configurations
- Test changes in development first

## Troubleshooting

### Common Issues

1. **Group Not Found**: Verify Azure AD group exists and SCIM is configured
2. **Permission Denied**: Check Databricks provider authentication
3. **Role Assignment Failed**: Verify role names are valid
4. **External ID Conflicts**: Ensure external_id is unique

### Debug Steps

1. Check Databricks workspace logs
2. Verify Azure AD SCIM configuration
3. Test with minimal configuration
4. Review Terraform state