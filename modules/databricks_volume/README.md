# Databricks Volume Module

This module creates and manages volumes in Databricks Unity Catalog. It supports both managed and external volumes with various cloud storage configurations.

## Usage

```hcl
# Example of a managed volume
module "managed_volume" {
  source = "./modules/databricks_volume"

  name         = "my_volume"
  catalog_name = "main"
  schema_name  = "default"
  volume_type  = "MANAGED"
  comment      = "My managed volume"
}

# Example of an external volume with Azure Storage
module "external_azure_volume" {
  source = "./modules/databricks_volume"

  name         = "azure_volume"
  catalog_name = "main"
  schema_name  = "external"
  volume_type  = "EXTERNAL"

  azure_storage_container = {
    container_name       = "my-container"
    storage_account_name = "mystorageaccount"
    path                = "/path/to/volume"
  }
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
| name | Name of the volume | string | n/a | yes |
| catalog_name | Name of the catalog where volume will be created | string | n/a | yes |
| schema_name | Name of the schema where volume will be created | string | n/a | yes |
| volume_type | Type of the volume (EXTERNAL or MANAGED) | string | "MANAGED" | no |
| storage_location | Storage location for the volume | string | null | no |
| comment | Comment describing the volume | string | null | no |
| owner | Owner of the volume | string | null | no |
| azure_storage_container | Azure Storage container configuration | object | null | no |

## Outputs

| Name | Description |
|------|-------------|
| volume_id | ID of the created volume |
| volume_name | Full name of the volume including catalog and schema |
| owner | Owner of the volume |
| storage_location | Storage location of the volume |