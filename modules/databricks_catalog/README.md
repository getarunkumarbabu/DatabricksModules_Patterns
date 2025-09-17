# Databricks Catalog Module

This module manages Unity Catalog catalogs in Databricks, which are the top-level containers for organizing data assets.

## Usage

```hcl
module "catalog" {
  source = "./modules/databricks_catalog"

  name       = "my_catalog"
  comment    = "My Unity Catalog catalog"
  owner      = "my-user@example.com"
  properties = {
    environment = "production"
    team        = "data_science"
  }
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the catalog | `string` | n/a | yes |
| comment | Description or comment about the catalog | `string` | `null` | no |
| properties | Map of catalog properties | `map(string)` | `{}` | no |
| owner | Username/group name/service principal application ID of the catalog owner | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| catalog_id | The ID of the catalog |
| catalog | The full catalog resource |