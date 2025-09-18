# Databricks Workspace Module

This module manages workspace configurations for Azure Databricks. It sets up and configures Databricks workspaces with the specified network, storage, and credentials configurations.

## Usage

```hcl
module "databricks_workspace" {
  source = "./modules/databricks_mws_workspaces"

  workspace_name            = "my-workspace"
  deployment_name          = "my-deployment"
  account_id               = "123456789"

  network_id               = module.network.network_id
  storage_configuration_id = module.storage.storage_configuration_id
  credentials_id           = module.credentials.credentials_id
  location                 = "eastus"
  pricing_tier            = "PREMIUM"
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
| workspace_name | Name of the workspace | `string` | n/a | yes |
| deployment_name | Name of the deployment | `string` | n/a | yes |
| account_id | Databricks account ID | `string` | n/a | yes |

| network_id | ID of the network configuration to use | `string` | n/a | yes |
| storage_configuration_id | ID of the storage configuration to use | `string` | n/a | yes |
| credentials_id | ID of the credentials configuration to use | `string` | n/a | yes |
| location | Azure region for the workspace | `string` | n/a | yes |
| pricing_tier | Pricing tier of the workspace (STANDARD or PREMIUM) | `string` | "STANDARD" | no |
| managed_resource_group | Name of the managed resource group | `string` | null | no |

## Outputs

| Name | Description |
|------|-------------|
| workspace_id | ID of the created workspace |
| workspace_name | Name of the workspace |
| workspace_status | Current status of the workspace |
| workspace_url | URL of the workspace |

## Example: Complete Workspace Configuration

```hcl
module "databricks_workspace_complete" {
  source = "./modules/databricks_mws_workspaces"

  workspace_name            = "production-workspace"
  deployment_name          = "prod-deployment"
  account_id               = var.databricks_account_id

  network_id               = module.databricks_network.network_id
  storage_configuration_id = module.databricks_storage.storage_configuration_id
  credentials_id           = module.databricks_credentials.credentials_id
  location                 = "eastus"
  pricing_tier            = "PREMIUM"
  managed_resource_group   = "databricks-prod-rg"
}
```