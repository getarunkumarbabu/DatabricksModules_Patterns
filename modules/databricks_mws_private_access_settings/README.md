# Databricks Private Access Settings Module

This module manages private access settings for Azure Databricks workspaces. It configures private access and network connectivity settings for secure access to Databricks resources.

## Usage

```hcl
module "databricks_private_access" {
  source = "./modules/databricks_mws_private_access_settings"

  private_access_settings_name = "my-private-access"
  region                    = "eastus"
  public_access_enabled     = false
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

| private_access_settings_name | Name of the private access settings configuration | `string` | n/a | yes |
| region | Azure region where the private access settings will be configured | `string` | n/a | yes |
| public_access_enabled | Whether public access should be enabled | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| private_access_settings_id | ID of the created private access settings |
| creation_time | Time when the private access settings were created |
| status | Current status of the private access settings |

## Example: Private Access Configuration

```hcl
module "databricks_private_access" {
  source = "./modules/databricks_mws_private_access_settings"

  private_access_settings_name = "private-access-config"
  region                    = "eastus"
  public_access_enabled     = false
}
```