# Unified Databricks Group Role Assignment Pattern

This pattern provides a comprehensive solution for managing Azure AD group role assignments in Databricks workspaces. It supports multiple admin and user groups with customizable roles, permissions, and Azure AD integration.

## Features

- **Azure AD Integration**: Direct integration with existing Azure AD groups via Object IDs
- **Admin Groups Support**: Automatic admin privileges for designated groups
- **Multiple User Groups**: Customizable roles and permissions for different user types
- **Service Principal Support**: Azure AD service principals with workspace access
- **Account-Level Groups**: Account-level group management for organization-wide access
- **Granular Permissions**: Fine-tuned access controls for clusters, SQL, and workspace
- **Comprehensive Validation**: Strong input validation and error handling
- **Rich Outputs**: Detailed configuration and permission summaries

## Prerequisites

### Azure AD Setup
1. **Groups Created**: Azure AD groups must already exist
2. **SCIM Enabled**: Azure AD SCIM provisioning configured for Databricks
3. **Object IDs Available**: Azure AD Group Object IDs for configuration

### Databricks Setup
1. **Workspace Access**: Proper authentication configured
2. **Account Permissions**: Account admin or workspace admin access
3. **SCIM Sync**: Active synchronization with Azure AD

### Terraform Setup
1. **Provider**: Databricks provider >= 1.0.0
2. **Authentication**: Proper Databricks authentication configured

## Usage

### Adding Existing AD Groups with Admin Privileges

1. **Get Azure AD Group Object IDs**:
```bash
# Azure CLI
az ad group list --query "[].{name:displayName, id:id}" -o table

# PowerShell
Get-AzureADGroup -Filter "DisplayName eq 'your-admin-group'" | Select ObjectId
```

2. **Configure Admin Groups**:
```hcl
admin_groups = [
  {
    display_name = "existing-admin-group@yourdomain.com"
    external_id  = "12345678-1234-1234-1234-123456789012"  # Azure AD Object ID
    allow_cluster_create = true
    databricks_sql_access = true
  }
]
```

3. **Deploy**:
```bash
terraform init
terraform plan
terraform apply
```

### Configuration Structure

#### Admin Groups
```hcl
admin_groups = [
  {
    display_name         = "databricks-admins@yourdomain.com"
    external_id          = "11111111-1111-1111-1111-111111111111"
    allow_cluster_create = true
    databricks_sql_access = true
  }
]
```

#### User Groups
```hcl
user_groups = [
  {
    display_name         = "databricks-data-scientists@yourdomain.com"
    external_id          = "33333333-3333-3333-3333-333333333333"
    roles               = ["user", "notebook_admin", "job_admin"]
    workspace_access    = true
    allow_cluster_create = true
    databricks_sql_access = true
  }
]
```

## Configuration Parameters

### Admin Groups

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| display_name | Azure AD group name | `string` | - | Yes |
| external_id | Azure AD Group Object ID | `string` | `null` | No |
| allow_cluster_create | Allow cluster creation | `bool` | `true` | No |
| databricks_sql_access | Grant SQL access | `bool` | `true` | No |

### User Groups

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| display_name | Azure AD group name | `string` | - | Yes |
| external_id | Azure AD Group Object ID | `string` | `null` | No |
| roles | List of roles to assign | `list(string)` | `["user"]` | No |
| workspace_access | Grant workspace access | `bool` | `true` | No |
| allow_cluster_create | Allow cluster creation | `bool` | `false` | No |
| databricks_sql_access | Grant SQL access | `bool` | `false` | No |

### Service Principals

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| application_id | Azure AD Application (Client) ID | `string` | - | Yes |
| display_name | Service principal display name | `string` | - | Yes |
| roles | List of roles to assign | `list(string)` | `["user"]` | No |
| workspace_access | Grant workspace access | `bool` | `true` | No |
| allow_cluster_create | Allow cluster creation | `bool` | `false` | No |
| databricks_sql_access | Grant SQL access | `bool` | `false` | No |

### Account Level Groups

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| display_name | Azure AD group name | `string` | - | Yes |
| external_id | Azure AD Group Object ID | `string` | `null` | No |
| roles | List of roles to assign | `list(string)` | `["account_admin"]` | No |
| members | List of member IDs | `list(string)` | `null` | No |

### Account Configuration

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| account_id | Databricks account ID | `string` | `null` | No* |

\* Required for account-level group management

## Available Roles

- **Admin Roles**: `admin`, `account_admin`, `super-admin`
- **Workspace Roles**: `workspace_admin`, `token_admin`, `notebook_admin`
- **Service Roles**: `cluster_admin`, `job_admin`, `sql_admin`
- **Specialized Roles**: `mlflow_admin`, `feature_store_admin`
- **Basic Roles**: `user`

## Outputs

### Group Configurations
- `admin_groups_config`: Detailed admin group configurations
- `user_groups_config`: Detailed user group configurations

### Summaries
- `all_group_assignments`: Combined group assignments
- `all_group_ids`: All group ID mappings
- `group_roles_summary`: Role assignments overview

### Statistics
- `group_counts`: Group counts by type
- `permission_summary`: Permission distribution summary

## Getting Azure AD Group Object IDs

### Method 1: Azure Portal
```
Azure AD > Groups > [Your Group] > Overview > Object ID
```

### Method 2: Azure CLI
```bash
# List all groups
az ad group list --query "[].{name:displayName, id:id}" -o table

# Get specific group
az ad group show --group "databricks-admins@yourdomain.com" --query id -o tsv
```

### Method 3: PowerShell
```powershell
# Get group by name
Get-AzureADGroup -Filter "DisplayName eq 'databricks-admins@yourdomain.com'" | Select ObjectId
```

## Adding Existing AD Groups with User Permissions

### Step-by-Step Guide

1. **Identify Your Azure AD Groups**:
```bash
# List all groups
az ad group list --query "[].{name:displayName, id:id}" -o table
```

2. **Configure User Groups with Appropriate Permissions**:
```hcl
user_groups = [
  # Data Scientists - Full access
  {
    display_name          = "data-scientists@yourdomain.com"
    external_id           = "11111111-1111-1111-1111-111111111111"
    roles                 = ["user", "notebook_admin", "job_admin"]
    workspace_access      = true
    allow_cluster_create  = true
    databricks_sql_access = true
  },
  # Data Analysts - SQL focused
  {
    display_name          = "data-analysts@yourdomain.com"
    external_id           = "22222222-2222-2222-2222-222222222222"
    roles                 = ["user", "sql_admin"]
    workspace_access      = true
    allow_cluster_create  = false
    databricks_sql_access = true
  },
  # Developers - Cluster and job management
  {
    display_name          = "developers@yourdomain.com"
    external_id           = "33333333-3333-3333-3333-333333333333"
    roles                 = ["user", "job_admin", "cluster_admin"]
    workspace_access      = true
    allow_cluster_create  = true
    databricks_sql_access = false
  },
  # Read-only users - Basic access only
  {
    display_name          = "readonly-users@yourdomain.com"
    external_id           = "44444444-4444-4444-4444-444444444444"
    roles                 = ["user"]
    workspace_access      = true
    allow_cluster_create  = false
    databricks_sql_access = false
  }
]
```

3. **Deploy the Configuration**:
```bash
terraform init
terraform plan
terraform apply
```

### Common User Group Scenarios

#### Data Science Teams
```hcl
{
  display_name          = "data-science-team@company.com"
  external_id           = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
  roles                 = ["user", "notebook_admin", "job_admin", "mlflow_admin"]
  workspace_access      = true
  allow_cluster_create  = true
  databricks_sql_access = true
}
```

#### Business Intelligence Teams
```hcl
{
  display_name          = "bi-team@company.com"
  external_id           = "bbbbbbbb-cccc-dddd-eeee-ffffffffffff"
  roles                 = ["user", "sql_admin", "feature_store_admin"]
  workspace_access      = true
  allow_cluster_create  = false
  databricks_sql_access = true
}
```

#### Development Teams
```hcl
{
  display_name          = "dev-team@company.com"
  external_id           = "cccccccc-dddd-eeee-ffff-gggggggggggg"
  roles                 = ["user", "job_admin", "cluster_admin", "token_admin"]
  workspace_access      = true
  allow_cluster_create  = true
  databricks_sql_access = false
}
```

#### External Contractors
```hcl
{
  display_name          = "contractors@company.com"
  external_id           = "dddddddd-eeee-ffff-gggg-hhhhhhhhhhhh"
  roles                 = ["user"]
  workspace_access      = true
  allow_cluster_create  = false
  databricks_sql_access = false
}
```

## Example Configurations

### Enterprise Setup
```hcl
admin_groups = [
  {
    display_name = "platform-admins@company.com"
    external_id  = "11111111-1111-1111-1111-111111111111"
  }
]

user_groups = [
  {
    display_name = "data-scientists@company.com"
    external_id  = "22222222-2222-2222-2222-222222222222"
    roles = ["user", "notebook_admin", "job_admin"]
    allow_cluster_create = true
  },
  {
    display_name = "analysts@company.com"
    external_id  = "33333333-3333-3333-3333-333333333333"
    roles = ["user", "sql_admin"]
    databricks_sql_access = true
  },
  {
    display_name = "developers@company.com"
    external_id  = "44444444-4444-4444-4444-444444444444"
    roles = ["user", "job_admin", "cluster_admin"]
    allow_cluster_create = true
  },
  {
    display_name = "readonly-users@company.com"
    external_id  = "55555555-5555-5555-5555-555555555555"
    roles = ["user"]
  }
]

service_principals = [
  {
    application_id = "44444444-4444-4444-4444-444444444444"
    display_name   = "ci-cd-service-principal"
    roles          = ["user", "job_admin"]
  }
]

account_level_groups = [
  {
    display_name = "account-admins@company.com"
    external_id  = "55555555-5555-5555-5555-555555555555"
    roles        = ["account_admin"]
  }
]

account_id = "1234567890123456"
```

### Minimal Setup
```hcl
admin_groups = [
  {
    display_name = "databricks-admins@domain.com"
    external_id  = "11111111-1111-1111-1111-111111111111"
  }
]

user_groups = [
  {
    display_name = "databricks-users@domain.com"
    external_id  = "22222222-2222-2222-2222-222222222222"
  }
]

service_principals = []

account_level_groups = []

account_id = null
```

## Best Practices

### Group Organization
1. **Consistent Naming**: Use clear, consistent group naming conventions
2. **Role Separation**: Separate admin and user groups appropriately
3. **Minimal Permissions**: Follow principle of least privilege
4. **Regular Audits**: Review group memberships periodically

### Configuration Management
1. **Version Control**: Keep configurations in Git
2. **Documentation**: Document group purposes and permissions
3. **Testing**: Test changes in development environments
4. **Backup**: Maintain backups of working configurations

### Azure AD Integration
1. **SCIM Monitoring**: Monitor SCIM synchronization status
2. **Group Management**: Manage groups primarily in Azure AD
3. **Object ID Tracking**: Keep track of Object IDs for reference
4. **Sync Validation**: Regularly validate group synchronization

## Troubleshooting

### Common Issues

1. **Group Not Found**
   - Verify SCIM synchronization is active
   - Check group names match exactly
   - Confirm Object IDs are correct

2. **Permission Errors**
   - Validate Databricks authentication
   - Check account admin permissions
   - Verify SCIM provisioning status

3. **Role Assignment Failures**
   - Confirm role names are valid
   - Check for conflicting permissions
   - Review Terraform error messages

### Debug Steps

1. **Check SCIM Status**
   ```bash
   # Verify in Databricks Account Console
   # Check Azure AD provisioning logs
   ```

2. **Validate Configuration**
   ```bash
   terraform validate
   terraform plan
   ```

3. **Test Minimal Setup**
   ```bash
   # Start with one group, then add more
   ```

## Security Considerations

### Access Control
- Regular permission audits
- Principle of least privilege
- Clear role definitions
- Audit logging review

### Compliance
- Group membership reviews
- Access certification
- Change management
- Documentation maintenance

## Maintenance

### Regular Tasks
- **Weekly**: Review group memberships
- **Monthly**: Audit permissions and access
- **Quarterly**: Update role definitions and policies

### Updates
- Test changes in development
- Document configuration changes
- Update documentation
- Communicate changes to users