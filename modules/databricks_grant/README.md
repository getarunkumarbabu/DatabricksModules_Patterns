# Databricks Grant Module

This module manages privileges grants in Databricks Unity Catalog, allowing you to control access to various objects (catalogs, schemas, tables, and volumes).

## Usage

```hcl
# Grant catalog privileges
module "catalog_grant" {
  source = "./modules/databricks_grant"

  principal     = "data_scientists"
  privileges    = ["USE_CATALOG", "USE_SCHEMA", "SELECT"]
  catalog_name = "analytics"
}

# Grant schema privileges
module "schema_grant" {
  source = "./modules/databricks_grant"

  principal            = "analysts"
  privileges           = ["USE_SCHEMA", "SELECT", "CREATE_TABLE"]
  schema_name         = "reporting"
  schema_catalog_name = "analytics"
}

# Grant table privileges
module "table_grant" {
  source = "./modules/databricks_grant"

  principal           = "ml_engineers"
  privileges          = ["SELECT", "MODIFY"]
  table_name         = "training_data"
  table_schema_name  = "ml_features"
  table_catalog_name = "ml"
}

# Grant volume privileges
module "volume_grant" {
  source = "./modules/databricks_grant"

  principal            = "data_engineers"
  privileges           = ["READ_VOLUME", "WRITE_VOLUME"]
  volume_name         = "raw_data"
  volume_schema_name  = "landing"
  volume_catalog_name = "data_lake"
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
| principal | Principal to grant privileges to | string | n/a | yes |
| privileges | List of privileges to grant | list(string) | n/a | yes |
| catalog_name | Name of catalog | string | null | no |
| schema_name | Name of schema | string | null | no |
| schema_catalog_name | Catalog containing schema | string | null | no |
| table_name | Name of table | string | null | no |
| table_schema_name | Schema containing table | string | null | no |
| table_catalog_name | Catalog containing table | string | null | no |
| volume_name | Name of volume | string | null | no |
| volume_schema_name | Schema containing volume | string | null | no |
| volume_catalog_name | Catalog containing volume | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| principal | Principal that was granted privileges |
| privileges | Privileges that were granted |
| object_type | Type of object granted on |
| object_name | Full name of object granted on |

## Notes

- Only one object type can be specified per grant
- Use appropriate privilege levels
- Consider principle of least privilege
- Monitor access patterns
- Regularly audit permissions
- Use groups for better management
- Document access policies