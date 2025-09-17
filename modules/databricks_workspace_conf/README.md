# Databricks Workspace Configuration Module

This module manages workspace-level configurations using the `databricks_workspace_conf` resource.

## Inputs

- `custom_config` (map(string)) - Map of workspace configurations to set
- `enable_serverless_compute` (bool, default: false) - Whether to enable serverless compute

## Outputs

- `workspace_conf` - The workspace configuration that was set

## Example

```hcl
module "workspace_conf" {
  source = "../modules/databricks_workspace_conf"
  
  custom_config = {
    "enable-serverless-compute" = "true"
    "enable-photon"            = "true"
  }
}
```

## Common Configurations

Some common workspace configurations:
- `enable-serverless-compute`: Enable serverless compute features
- `enable-photon`: Enable Photon execution engine
- `enableIpAccessLists`: Enable IP access lists feature
- `enableTokensConfig`: Enable token-based authentication
- `enableWorkspaceFilesystem`: Enable workspace filesystem