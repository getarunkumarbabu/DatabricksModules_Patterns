# Databricks Table Module

This module creates and manages tables in Databricks Unity Catalog. It supports both managed and external tables with various configuration options.

## Usage

```hcl
# Example of a managed Delta table
module "managed_table" {
  source = "./modules/databricks_table"

  name          = "my_table"
  catalog_name  = "main"
  schema_name   = "default"
  table_type    = "MANAGED"

  columns = [
    {
      name      = "id"
      type_name = "int"
      type_text = "INT"
      position  = 1
      nullable  = false
    },
    {
      name      = "name"
      type_name = "string"
      type_text = "STRING"
      position  = 2
      comment   = "Name of the entity"
    },
    {
      name      = "created_at"
      type_name = "timestamp"
      type_text = "TIMESTAMP"
      position  = 3
    }
  ]

  partition_columns = ["created_at"]
  cluster_keys     = ["id"]

  properties = {
    delta.autoOptimize.optimizeWrite = "true"
    delta.autoOptimize.autoCompact   = "true"
  }
}

# Example of an external Delta table
module "external_table" {
  source = "./modules/databricks_table"

  name             = "external_table"
  catalog_name     = "main"
  schema_name      = "external"
  table_type       = "EXTERNAL"
  storage_location = "abfss://container@storageaccount.dfs.core.windows.net/path/to/table"

  columns = [
    {
      name      = "id"
      type_name = "int"
      type_text = "INT"
      position  = 1
    },
    {
      name      = "data"
      type_name = "string"
      type_text = "STRING"
      position  = 2
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the table | string | n/a | yes |
| catalog_name | Name of the catalog where table will be created | string | n/a | yes |
| schema_name | Name of the schema where table will be created | string | n/a | yes |
| table_type | Type of the table (MANAGED or EXTERNAL) | string | "MANAGED" | no |
| data_source_format | Data source format for the table | string | "DELTA" | no |
| comment | Comment describing the table | string | null | no |
| owner | Owner of the table | string | null | no |
| columns | List of columns in the table | list(object) | n/a | yes |
| storage_location | Storage location for external tables | string | null | no |
| partition_columns | List of column names to partition by | list(string) | null | no |
| cluster_keys | List of column names to cluster by | list(string) | null | no |
| properties | Properties of the table | map(string) | {} | no |
| tblproperties | Additional table properties | map(string) | null | no |

## Outputs

| Name | Description |
|------|-------------|
| table_id | ID of the created table |
| table_name | Full name of the table including catalog and schema |
| owner | Owner of the table |
| storage_location | Storage location of the table |