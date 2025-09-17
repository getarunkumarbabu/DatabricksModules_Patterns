# Databricks Metastore Assignment Module

This module manages metastore assignments in Databricks, allowing you to associate a metastore with a workspace and optionally set a default catalog.

## Usage

```hcl
module "metastore_assignment" {
  source = "./modules/databricks_metastore_assignment"

  metastore_id         = "your_metastore_id"
  workspace_id         = "your_workspace_id"
  default_catalog_name = "your_default_catalog"  # Optional
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
| metastore_id | ID of the metastore to assign | `string` | n/a | yes |
| workspace_id | ID of the workspace to assign the metastore to | `string` | n/a | yes |
| default_catalog_name | Name of the default catalog to use for the metastore assignment | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| metastore_id | ID of the assigned metastore |
| workspace_id | ID of the workspace the metastore is assigned to |
| default_catalog_name | Name of the default catalog for the metastore assignment |

## Example: Basic Assignment

```hcl
module "basic_metastore_assignment" {
  source = "./modules/databricks_metastore_assignment"

  metastore_id = "12345"
  workspace_id = "67890"
}
```

## Example: Assignment with Default Catalog

```hcl
module "metastore_assignment_with_catalog" {
  source = "./modules/databricks_metastore_assignment"

  metastore_id         = "12345"
  workspace_id         = "67890"
  default_catalog_name = "default_catalog"
}
```