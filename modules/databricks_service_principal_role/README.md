# Databricks Service Principal Role Module

This module manages role assignments for Databricks service principals. It allows you to assign workspace-level roles to service principals for automated access to Databricks resources.

## Usage

```hcl
module "databricks_automation_sp" {
  source = "./modules/databricks_service_principal_role"

  service_principal_name = "automation-sp"
  application_id        = "00000000-0000-0000-0000-000000000000"
  workspace_access      = true
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
| service_principal_name | Display name for the service principal | `string` | n/a | yes |
| application_id | Application (client) ID of the service principal | `string` | n/a | yes |
| workspace_access | Whether to grant workspace access | `bool` | `true` | no |
| roles | List of roles to assign to the service principal | `list(string)` | n/a | yes |

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
| service_principal_id | ID of the service principal |
| service_principal_name | Name of the service principal |
| application_id | Application ID of the service principal |
| assigned_roles | List of roles assigned to the service principal |

## Example: Complete Service Principal Role Configuration

```hcl
module "databricks_service_principals" {
  source = "./modules/databricks_service_principal_role"

  for_each = {
    automation = {
      name = "automation-sp"
      app_id = "00000000-0000-0000-0000-000000000000"
      roles = ["workspace_admin", "cluster_admin"]
    },
    monitoring = {
      name = "monitoring-sp"
      app_id = "11111111-1111-1111-1111-111111111111"
      roles = ["cluster_admin"]
    }
  }

  service_principal_name = each.value.name
  application_id        = each.value.app_id
  roles                = each.value.roles
}
```