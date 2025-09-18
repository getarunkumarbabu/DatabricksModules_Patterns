# Databricks Access Control Rule Set Module

This module manages access control rules for Databricks resources. It provides a way to define and manage access control permissions for various Databricks objects.

## Usage

```hcl
module "databricks_access_control" {
  source = "./modules/databricks_access_control_rule_set"

  cluster_id = databricks_cluster.example.id
  access_rules = [
    {
      principal = "users"
      permission_level = "CAN_ATTACH_TO"
    },
    {
      principal = "admins"
      permission_level = "CAN_MANAGE"
    }
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
| cluster_id | ID of the Databricks cluster to apply access control rules to | `string` | n/a | yes |
| access_rules | List of access control rules | `list(object)` | n/a | yes |

The `access_rules` variable expects a list of objects with the following structure:
```hcl
object({
  principal         = string # Group name or username
  permission_level  = string # One of: CAN_MANAGE, CAN_ATTACH_TO, CAN_RESTART
})
```

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | ID of the cluster the rules are applied to |
| access_control_rules | List of applied access control rules |

## Example: Complete Access Control Configuration

```hcl
module "databricks_cluster_access" {
  source = "./modules/databricks_access_control_rule_set"

  cluster_id = databricks_cluster.production.id
  access_rules = [
    {
      principal = "data-scientists"
      permission_level = "CAN_ATTACH_TO"
    },
    {
      principal = "cluster-admins"
      permission_level = "CAN_MANAGE"
    },
    {
      principal = "support-team"
      permission_level = "CAN_RESTART"
    }
  ]
}
```