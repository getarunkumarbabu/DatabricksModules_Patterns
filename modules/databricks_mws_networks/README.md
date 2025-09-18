# Databricks Networks Module

This module manages network configurations for Azure Databricks workspaces. It sets up the networking components required for Databricks workspace deployment.

## Usage

```hcl
module "databricks_network" {
  source = "./modules/databricks_mws_networks"

  account_id   = "123456789"
  network_name = "my-network"
  workspace_id = module.workspace.workspace_id
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
| account_id | Databricks account ID | `string` | n/a | yes |
| network_name | Name of the network configuration | `string` | n/a | yes |
| workspace_id | ID of the workspace to associate with this network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network_id | ID of the created network configuration |
| creation_time | Time when the network configuration was created |
| network_name | Name of the network configuration |

## Example: Basic Network Configuration

```hcl
module "databricks_network_basic" {
  source = "./modules/databricks_mws_networks"

  account_id   = var.databricks_account_id
  network_name = "primary-network"
  workspace_id = module.workspace.workspace_id
}
```