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
4. **PAT Token**: Personal Access Token generated for authentication

### Terraform Setup
1. **Provider**: Databricks provider >= 1.0.0
2. **Authentication**: Databricks workspace URL and PAT token configured
3. **Backend**: Optional Azure backend for state management

## Authentication Configuration

### Generate Personal Access Token (PAT)

1. **Login to Databricks Workspace**:
   - Navigate to your Azure Databricks workspace
   - Click on your username in the top right corner
   - Select "User Settings"

2. **Generate Token**:
   - Go to the "Developer" tab
   - Click "Manage" next to "Access tokens"
   - Click "Generate new token"
   - Provide a comment (e.g., "Terraform Deployment")
   - Set expiration (recommended: 90 days or less for security)
   - Copy the generated token immediately (it won't be shown again)

### Configure Authentication Variables

Create a `terraform.tfvars` file or use environment variables:

```hcl
# Method 1: terraform.tfvars file
databricks_host  = "https://adb-1234567890123456.12.azuredatabricks.net"
databricks_token = "dapi-your-actual-pat-token-here"
```

```bash
# Method 2: Environment variables (recommended for CI/CD)
export DATABRICKS_HOST="https://adb-1234567890123456.12.azuredatabricks.net"
export DATABRICKS_TOKEN="dapi-your-actual-pat-token-here"
```

### Find Your Databricks Workspace URL

Your workspace URL can be found in the Azure portal:
1. Go to your Databricks workspace resource
2. Copy the "Workspace URL" from the overview page
3. It should look like: `https://adb-<numbers>.<region>.azuredatabricks.net`

## Files Overview

- **`main.tf`**: Main configuration with provider setup and module calls
- **`variables.tf`**: Input variable definitions with validation
- **`outputs.tf`**: Output definitions for group IDs and configurations
- **`example.tfvars`**: Sample configuration values
- **`terraform.tfvars`**: Your actual configuration (create from example)
- **`deploy.sh`**: Linux/Mac deployment script
- **`deploy.ps1`**: Windows PowerShell deployment script
- **`.gitignore`**: Prevents committing sensitive files

## Security Considerations

### PAT Token Security
- **Never commit tokens to version control**
- **Use short-lived tokens** (maximum 90 days recommended)
- **Rotate tokens regularly** for production environments
- **Use environment variables** instead of files for CI/CD pipelines
- **Store tokens securely** using Azure Key Vault or similar services

### State Management
- **Use remote state** for team collaboration
- **Enable state locking** to prevent concurrent modifications
- **Backup state files** regularly
- **Use Azure backend** for production deployments

### Access Control
- **Principle of least privilege** when assigning roles
- **Regular audit** of group memberships and permissions
- **Monitor token usage** in Databricks admin console

## Usage

### Quick Start

1. **Clone the repository**:
```bash
git clone <repository-url>
cd DatabricksModules_Patterns/patterns/unified-databricks-setup
```

2. **Configure Authentication**:
```bash
# Copy example configuration
cp example.tfvars terraform.tfvars

# Edit terraform.tfvars with your actual values
# - Update databricks_host with your workspace URL
# - Update databricks_token with your PAT token
# - Configure your Azure AD groups and service principals
```

3. **Initialize and Deploy**:
```bash
# Initialize Terraform (downloads Databricks provider)
terraform init

# Review the deployment plan
terraform plan

# Apply the configuration
terraform apply
```

#### Using Deployment Scripts

For easier deployment, use the provided scripts:

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Windows PowerShell:**
```powershell
.\deploy.ps1
```

**Validation Only:**
```powershell
# Validate configuration without deploying
.\deploy.ps1 -ValidateOnly
```

**Skip Plan (Direct Apply):**
```powershell
# Apply directly without showing plan
.\deploy.ps1 -SkipPlan
```

### Advanced Configuration

#### Using Azure Backend for State Management

For production deployments, configure Azure backend for state management:

```hcl
# In main.tf, uncomment and configure the backend block:
backend "azurerm" {
  resource_group_name  = "your-resource-group"
  storage_account_name = "yourstorageaccount"
  container_name       = "tfstate"
  key                  = "databricks-setup.tfstate"
}

# Add to terraform.tfvars:
resource_group_name  = "your-resource-group"
storage_account_name = "yourstorageaccount"
```

#### Environment Variables (Recommended for CI/CD)

```bash
export DATABRICKS_HOST="https://adb-1234567890123456.12.azuredatabricks.net"
export DATABRICKS_TOKEN="dapi-your-actual-pat-token-here"
export ARM_CLIENT_ID="your-azure-service-principal-client-id"
export ARM_CLIENT_SECRET="your-azure-service-principal-secret"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"
```

### Using Existing Azure AD Groups

This pattern now supports both creating new groups and referencing existing SCIM-synced Azure AD groups. When `external_id` is provided, the module will reference the existing group instead of creating a new one.

#### Benefits of Using Existing Groups
- **SCIM Synchronization**: Groups are automatically synced from Azure AD
- **Centralized Management**: Group membership managed in Azure AD
- **Reduced Complexity**: No need to manage group lifecycle in Terraform
- **Consistency**: Single source of truth for group membership

#### Finding Azure AD Group Object IDs

```bash
# Azure CLI - List all groups
az ad group list --query "[].{name:displayName, id:id}" -o table

# Azure CLI - Find specific group
az ad group list --filter "displayName eq 'Data Scientists'" --query "[].id" -o tsv

# PowerShell
Get-AzureADGroup -Filter "DisplayName eq 'your-group-name'" | Select ObjectId
```

#### Configuring Existing Groups

```hcl
# Admin groups using existing Azure AD groups
admin_groups = [
  {
    display_name         = "existing-admins@yourdomain.com"
    external_id          = "12345678-1234-1234-1234-123456789012"  # Required for existing groups
    allow_cluster_create = true
    databricks_sql_access = true
  }
]

# User groups using existing Azure AD groups
user_groups = [
  {
    display_name         = "existing-data-scientists@yourdomain.com"
    external_id          = "87654321-4321-4321-4321-210987654321"  # Required for existing groups
    roles               = ["user", "notebook_admin", "job_admin"]
    allow_cluster_create = true
    databricks_sql_access = true
  }
]
```

#### Creating New Groups (When external_id is omitted)

```hcl
# New groups created by Terraform
user_groups = [
  {
    display_name         = "new-data-engineers"  # No external_id = create new group
    roles               = ["user", "cluster_admin"]
    allow_cluster_create = true
    databricks_sql_access = true
  }
]
```

### Adding Existing AD Groups with Admin Privileges

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

### Authentication Configuration

| Parameter | Description | Type | Default | Required |
|-----------|-------------|------|---------|:--------:|
| databricks_host | Databricks workspace URL | `string` | - | Yes |
| databricks_token | Personal Access Token for authentication | `string` | - | Yes |
| resource_group_name | Azure resource group for state storage | `string` | `null` | No |
| storage_account_name | Azure storage account for state storage | `string` | `null` | No |
| container_name | Azure storage container for state | `string` | `tfstate` | No |
| key | Terraform state file key | `string` | `databricks-setup.tfstate` | No |

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

## Known Limitations

### Provider Version Compatibility
- **Databricks Provider v0.6.2**: Role assignment resources (`databricks_group_role`, `databricks_service_principal_role`) are not available
- **Account-level Groups**: Account-level group management is not supported in older provider versions
- **Workspace Access**: `databricks_workspace_access` resource is not available

### Recommended Upgrades
For full functionality including role assignments, consider upgrading:
- **Terraform**: >= 1.0.0 (currently using 1.13.2)
- **Databricks Provider**: >= 1.0.0 (currently using 0.6.2)

### Current Capabilities
✅ **Group Creation**: Azure AD integrated groups  
✅ **Basic Permissions**: Cluster create, SQL access settings  
✅ **SCIM Integration**: External ID management  
✅ **Member Management**: Direct group membership  

⚠️ **Role Assignment**: Configured but not assigned (provider limitation)

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