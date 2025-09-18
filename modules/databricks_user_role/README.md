# Databricks User Role Module

This module manages role assignments for Databricks users. It allows you to assign workspace-level roles to users for controlling their access to Databricks resources.

## Usage

```hcl
module "databricks_admin_user" {
  source = "./modules/databricks_user_role"

  user_name        = "admin@example.com"
  workspace_access = true
  roles = [
    "workspace_admin",
    "cluster_admin"
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| user_name | Email address of the user | `string` | n/a | yes |
| workspace_access | Whether to grant workspace access | `bool` | `true` | no |
| display_name | Display name for the user | `string` | `null` | no |
| roles | List of roles to assign to the user | `list(string)` | n/a | yes |

Valid roles are:
- admin
- user
- account_admin
- cluster_admin
- workspace_admin
- token_admin
- notebook_admin

## Outputs

| Name | Description |
|------|-------------|
| user_id | ID of the user |
| user_name | Username (email) of the user |
| display_name | Display name of the user |
| assigned_roles | List of roles assigned to the user |

## Example: Complete User Role Configuration

```hcl
module "databricks_users" {
  source = "./modules/databricks_user_role"

  for_each = {
    admin = {
      email = "admin@example.com"
      name  = "Admin User"
      roles = ["workspace_admin", "cluster_admin"]
    },
    analyst = {
      email = "analyst@example.com"
      name  = "Data Analyst"
      roles = ["user"]
    },
    engineer = {
      email = "engineer@example.com"
      name  = "Data Engineer"
      roles = ["cluster_admin"]
    }
  }

  user_name     = each.value.email
  display_name  = each.value.name
  roles         = each.value.roles
}
```