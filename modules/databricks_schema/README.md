# Databricks Schema Module

This module manages Unity Catalog schemas in Databricks, which are containers for organizing tables and views within a catalog.

## Usage

```hcl
module "schema" {
  source = "./modules/databricks_schema"

  catalog_name = "my_catalog"
  name         = "my_schema"
  comment      = "My Unity Catalog schema"
  owner        = "my-user@example.com"
  properties   = {
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
| catalog_name | The name of the catalog containing the schema | `string` | n/a | yes |
| name | The name of the schema | `string` | n/a | yes |
| comment | Description or comment about the schema | `string` | `null` | no |
| properties | Map of schema properties | `map(string)` | `{}` | no |
| owner | Username/group name/service principal application ID of the schema owner | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| schema_id | The ID of the schema |
| schema | The full schema resource |