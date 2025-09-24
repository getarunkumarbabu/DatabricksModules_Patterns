# Databricks Terraform Modules

This repository contains a collection of Terraform modules for managing Databricks resources. These modules provide a standardized way to create and manage various Databricks resources using Infrastructure as Code.

## Available Modules

### Identity and Access Management

#### Groups
- **[databricks_account_group](./modules/databricks_account_group)** - Create and manage account-level groups
- **[databricks_group](./modules/databricks_group)** - Create and manage workspace-level groups
- **[databricks_group_role](./modules/databricks_group_role)** - Create groups with comprehensive role assignments and permissions
- **[databricks_group_member](./modules/databricks_group_member)** - Manage group memberships (add users/service principals to groups)

#### Service Principals
- **[databricks_service_principal_role](./modules/databricks_service_principal_role)** - Create service principals and assign workspace-level roles

## Available Patterns

### Complete Setup Patterns
- **[unified-databricks-setup](./patterns/unified-databricks-setup)** - Complete Databricks workspace setup with Azure AD integration, groups, service principals, and role assignments

## Requirements

- Terraform >= 0.13
- Databricks Provider >= 1.0.0

## Usage

Each module can be used independently. Here's a basic example that combines multiple modules:

```hcl
# Create an account-level group
module "account_group" {
  source = "./modules/databricks_account_group"

  display_name = "account-admins"
  account_id   = "1234567890123456"
  members      = ["admin@example.com"]
}

# Create a workspace-level group with roles
module "workspace_group" {
  source = "./modules/databricks_group_role"

  group_name       = "data-scientists"
  external_id      = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"  # Azure AD Group ID
  roles            = ["user", "notebook_admin", "job_admin"]
  workspace_access = true
  allow_cluster_create = true
  databricks_sql_access = true
}

# Add additional members to the group
module "group_membership" {
  source = "./modules/databricks_group_member"

  group_id  = module.workspace_group.group_id
  member_id = "user@example.com"
}

# Create a service principal with roles
module "service_principal" {
  source = "./modules/databricks_service_principal_role"

  application_id = "bbbbbbbb-cccc-dddd-eeee-ffffffffffff"
  display_name   = "automation-sp"
  roles          = ["user", "job_admin"]
}
```

## Documentation

Each module has its own README with:
- Detailed usage instructions
- Input variables
- Output values
- Example configurations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
