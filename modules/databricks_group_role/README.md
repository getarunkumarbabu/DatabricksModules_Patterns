# Databricks Group Role Module

This module manages role assignments for Databricks groups. It allows you to assign workspace-level roles to groups for controlling access to Databricks resources.

## Usage

```hcl
module "databricks_admin_group" {
  source = "./modules/databricks_group_role"

  group_name = "workspace-admins"
  workspace_access = true
  roles = [
    "admin",
    "user"
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
| group_name | Name of the Databricks group | `string` | n/a | yes |
| workspace_access | Whether to grant workspace access to the group | `bool` | `true` | no |
| roles | List of roles to assign to the group | `list(string)` | n/a | yes |

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
| group_id | ID of the group |
| group_name | Name of the group |
| assigned_roles | List of roles assigned to the group |

## Example: Complete Group Role Configuration

```hcl
module "databricks_user_groups" {
  source = "./modules/databricks_group_role"

  for_each = {
    admins = {
      name = "workspace-admins"
      roles = ["admin", "workspace_admin"]
    },
    users = {
      name = "workspace-users"
      roles = ["user"]
    },
    cluster_managers = {
      name = "cluster-admins"
      roles = ["cluster_admin"]
    }
  }

  group_name = each.value.name
  roles      = each.value.roles
}
```