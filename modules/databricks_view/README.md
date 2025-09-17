# Databricks View Module

This module manages Databricks SQL views in Unity Catalog.

## Usage

```hcl
module "example_view" {
  source = "./modules/databricks_view"

  name     = "my_example_view"
  catalog  = "my_catalog"
  schema   = "my_schema"
  sql      = "SELECT * FROM my_table"
  comment  = "Example view for demonstration"
  is_temp  = false

  permissions = [
    {
      principal  = "account users"
      privileges = ["SELECT", "USE_CATALOG"]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the view | `string` | n/a | yes |
| catalog | Name of the catalog | `string` | n/a | yes |
| schema | Name of the schema | `string` | n/a | yes |
| sql | SQL query defining the view | `string` | n/a | yes |
| comment | Comment for the view | `string` | `null` | no |
| cluster_id | ID of the cluster to run the view query on | `string` | `null` | no |
| is_temp | Whether the view is temporary | `bool` | `false` | no |
| permissions | Permissions configuration for the view | `list(object({ principal = string, privileges = list(string) }))` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| view_id | The ID of the created SQL view |
| view_name | The name of the SQL view |
| catalog_name | The name of the catalog containing the view |
| schema_name | The name of the schema containing the view |