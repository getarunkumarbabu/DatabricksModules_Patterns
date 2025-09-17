# Databricks Metastore Module

This module manages Unity Catalog metastores in Databricks, which are the top-level containers for organizing data assets across multiple workspaces.

## Usage

```hcl
module "metastore" {
  source = "./modules/databricks_metastore"

  name          = "my_metastore"
  storage_root  = "s3://my-bucket/metastore"
  region        = "us-west-2"
  owner         = "my-user@example.com"
  force_destroy = false
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
| name | The name of the metastore | `string` | n/a | yes |
| storage_root | The storage root URL for the metastore (e.g., s3://, abfss://, gs://) | `string` | n/a | yes |
| region | The region where the metastore should be created | `string` | n/a | yes |
| owner | Username/group name/service principal application ID of the metastore owner | `string` | `null` | no |
| force_destroy | Whether to force destroy the metastore even if it contains data | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| metastore_id | The ID of the metastore |
| metastore | The full metastore resource |