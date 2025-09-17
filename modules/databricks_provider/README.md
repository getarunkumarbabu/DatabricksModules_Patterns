# Databricks Provider Module

This module configures the Databricks provider with Azure integration support.

## Example Usage

```hcl
module "databricks_provider" {
  source = "./modules/databricks_provider"

  azure_workspace_resource_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Databricks/workspaces/example"
  host                       = "https://adb-workspace.azuredatabricks.net"
  
  # Using Service Principal authentication
  azure_client_id     = "client-id"
  azure_client_secret = "client-secret"
  azure_tenant_id     = "tenant-id"
}
```

## Authentication Methods

1. Azure Workspace Resource ID + Service Principal:
```hcl
module "databricks_provider" {
  source = "./modules/databricks_provider"

  azure_workspace_resource_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Databricks/workspaces/example"
  azure_client_id            = "client-id"
  azure_client_secret        = "client-secret"
  azure_tenant_id           = "tenant-id"
}
```

2. Personal Access Token:
```hcl
module "databricks_provider" {
  source = "./modules/databricks_provider"

  host  = "https://adb-workspace.azuredatabricks.net"
  token = "dapi1234567890"
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
| azure_workspace_resource_id | The Azure resource ID for the Databricks workspace | string | null | no |
| host | The Databricks host URL | string | null | no |
| token | The Databricks personal access token | string | null | no |
| azure_client_id | Azure client ID for service principal | string | null | no |
| azure_client_secret | Azure client secret for service principal | string | null | no |
| azure_tenant_id | Azure tenant ID for service principal | string | null | no |
| auth | Authentication configuration block | object | null | no |

## Security Note

All sensitive variables (token, client secrets) are marked as sensitive to ensure they are not logged or displayed in outputs.