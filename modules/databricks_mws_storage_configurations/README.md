# Databricks Storage Configuration Module

This module manages storage configurations for Azure Databricks workspaces. It sets up the storage account configurations required for Databricks workspace deployment.

## Usage

```hcl
module "databricks_storage" {
  source = "./modules/databricks_mws_storage_configurations"

  account_id                = "123456789"
  storage_configuration_name = "my-storage"
  container_name            = "mycontainer"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| databricks | >= 1.0.0 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| storage_configuration_name | Name of the storage configuration | `string` | n/a | yes |
| account_id | Databricks account ID | `string` | n/a | yes |
| container_name | Azure storage container name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| storage_configuration_id | ID of the created storage configuration |
| creation_time | Time when the storage configuration was created |
| storage_configuration_name | Name of the storage configuration |

## Example: Basic Storage Configuration

```hcl
module "databricks_storage_basic" {
  source = "./modules/databricks_mws_storage_configurations"

  account_id                = var.databricks_account_id
  storage_configuration_name = "main-storage"
  container_name            = "dbfs"
}
```