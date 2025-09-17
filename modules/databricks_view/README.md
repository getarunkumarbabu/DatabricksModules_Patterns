# Databricks View Module

This module manages Databricks SQL views in Unity Catalog.

## Usage

```hcl
module "example_view" {
  source = "./modules/databricks_view"

  view_name    = "my_example_view"
  catalog_name = "my_catalog"
  schema_name  = "my_schema"
  query        = "SELECT * FROM my_table"
  comment      = "Example view for demonstration"

  grants = [
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
| view_name | Name of the SQL view | `string` | n/a | yes |
| catalog_name | Name of the catalog where the view will be created | `string` | n/a | yes |
| schema_name | Name of the schema where the view will be created | `string` | n/a | yes |
| comment | Comment description for the view | `string` | `null` | no |
| query | SQL query that defines the view | `string` | n/a | yes |
| grants | Grants for the view | `list(object({ principal = string, privileges = list(string) }))` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| view_id | The ID of the created SQL view |
| view_name | The name of the SQL view |
| catalog_name | The name of the catalog containing the view |
| schema_name | The name of the schema containing the view |