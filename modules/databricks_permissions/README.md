# Databricks Permissions Module

This module manages permissions for various Databricks resources.

## Example Usage

```hcl
module "permissions" {
  source = "./modules/databricks_permissions"

  sql_endpoint_id = "endpoint-id"
  
  access_controls = [
    {
      group_name       = "data-scientists"
      permission_level = "CAN_USE"
    },
    {
      service_principal_name = "automation-sp"
      permission_level      = "CAN_MANAGE"
    },
    {
      user_name        = "john.doe@example.com"
      permission_level = "IS_OWNER"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [databricks_permissions.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/permissions) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sql_endpoint_id | The ID of the SQL endpoint to set permissions on | string | null | no |
| cluster_id | The ID of the cluster to set permissions on | string | null | no |
| job_id | The ID of the job to set permissions on | string | null | no |
| notebook_path | The path of the notebook to set permissions on | string | null | no |
| pipeline_id | The ID of the pipeline to set permissions on | string | null | no |
| access_controls | List of access control configurations | list(object) | [] | no |

## Permission Levels

The following permission levels are supported:
- CAN_USE: User can use the resource
- CAN_MANAGE: User can manage the resource
- CAN_VIEW: User can view the resource
- CAN_RUN: User can run the resource
- IS_OWNER: User is the owner of the resource