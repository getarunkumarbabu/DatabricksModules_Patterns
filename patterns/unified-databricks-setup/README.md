# Databricks Admin Role Assignment Pattern

This pattern assigns admin privileges to an existing Azure AD group in Databricks.

## Prerequisites

1. The Azure AD group must already exist in Azure Active Directory
2. Azure AD should be configured and synchronized with Databricks
3. You must have permissions to assign roles in Databricks

## Features

- Assigns admin role to an existing Azure AD group
- Enables workspace access for group members
- No group creation - works with your existing Azure AD groups

## Usage

1. Copy `example.tfvars` to `terraform.tfvars` and update the value:

```hcl
existing_admin_group_name = "your-ad-group@yourdomain.com"
```

2. Initialize and apply the Terraform configuration:

```bash
terraform init
terraform plan
terraform apply
```

## Variables

### Required Variables

- `existing_admin_group_name`: Name of the existing Azure AD group to be assigned admin role

## Outputs

- `admin_group_roles`: List of roles assigned to the group in Databricks

## Best Practices

1. Use a dedicated Azure AD group for Databricks administrators
2. Follow the principle of least privilege
3. Regularly audit group membership in Azure AD
4. Document group purpose and membership criteria
5. Ensure Azure AD synchronization is properly configured

## Note

This pattern assumes:
- The Azure AD group already exists
- Azure AD is properly configured and synchronized with Databricks
- The group name matches exactly with what's in Azure AD