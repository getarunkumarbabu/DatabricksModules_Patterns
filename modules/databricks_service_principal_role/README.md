# Databricks Service Principal Role Module# Databricks Service Principal Role Module



This module creates a Databricks service principal and assigns roles to it.This module manages role assignments for Databricks service principals. It allows you to assign workspace-level roles to service principals for automated access to Databricks resources.



## Usage## Usage



```hcl```hcl

module "service_principal" {module "databricks_automation_sp" {

  source = "../../modules/databricks_service_principal_role"  source = "./modules/databricks_service_principal_role"



  application_id = "12345678-1234-1234-1234-123456789012"  service_principal_name = "automation-sp"

  display_name   = "My Service Principal"  application_id        = "00000000-0000-0000-0000-000000000000"

  roles          = ["admin", "user"]  workspace_access      = true

  workspace_access = true  roles = [

}    "workspace_admin",

```    "cluster_admin"

  ]

## Inputs}

```

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|----------|## Requirements

| application_id | Azure AD application ID for the service principal | `string` | n/a | yes |

| display_name | Display name for the service principal | `string` | n/a | yes || Name | Version |

| roles | List of roles to assign to the service principal | `list(string)` | `["user"]` | no ||------|---------|

| workspace_access | Whether to grant workspace access | `bool` | `true` | no || terraform | >= 0.13.0 |

| allow_cluster_create | Whether to allow cluster creation | `bool` | `false` | no || databricks | >= 1.0.0 |

| databricks_sql_access | Whether to grant Databricks SQL access | `bool` | `false` | no |

## Providers

## Outputs

| Name | Version |

| Name | Description ||------|---------|

|------|-------------|| databricks | >= 1.0.0 |

| service_principal_id | The ID of the created service principal |

| application_id | The application ID of the service principal |## Input Variables

| display_name | The display name of the service principal |
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