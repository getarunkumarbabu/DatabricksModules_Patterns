# Databricks External Location Module

This module manages Unity Catalog external locations in Databricks, which define the storage locations outside of the managed Unity Catalog storage.

## Usage

```hcl
module "external_location" {
  source = "./modules/databricks_external_location"

  name            = "my_external_location"
  url             = "s3://my-bucket/external"
  credential_name = "my_storage_credential"
  comment         = "My external location for data lake access"
  owner           = "my-user@example.com"
  read_only      = false
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
| name | The name of the external location | `string` | n/a | yes |
| url | The URL of the external location (e.g., s3://, abfss://, gs://) | `string` | n/a | yes |
| credential_name | The name of the storage credential to use for this external location | `string` | n/a | yes |
| comment | Description or comment about the external location | `string` | `null` | no |
| owner | Username/group name/service principal application ID of the external location owner | `string` | `null` | no |
| read_only | Whether the external location is read-only | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| external_location_id | The ID of the external location |
| external_location | The full external location resource |