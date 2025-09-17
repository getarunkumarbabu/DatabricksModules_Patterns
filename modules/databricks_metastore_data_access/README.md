# Databricks Metastore Data Access Module

This module manages data access configurations for Databricks metastores, specifically for Azure managed identities.

## Usage

```hcl
module "metastore_data_access" {
  source = "./modules/databricks_metastore_data_access"

  metastore_id        = "your_metastore_id"
  name                = "azure_mi_access"
  owner               = "your_owner"
  access_connector_id = "your_access_connector_id"
  credential_id       = "your_credential_id"
  is_default         = true
  comment            = "Azure Managed Identity access configuration"
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
| metastore_id | ID of the metastore to configure data access for | `string` | n/a | yes |
| name | Name of the data access configuration | `string` | n/a | yes |
| owner | Owner of the data access configuration | `string` | n/a | yes |
| access_connector_id | Azure managed identity access connector ID | `string` | n/a | yes |
| credential_id | Azure managed identity credential ID | `string` | n/a | yes |
| is_default | Whether this is the default data access configuration | `bool` | `false` | no |
| comment | Comment for the data access configuration | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| metastore_id | ID of the metastore |
| name | Name of the data access configuration |
| access_connector_id | Azure managed identity access connector ID |
| credential_id | Azure managed identity credential ID |

## Example: Basic Azure Managed Identity Access

```hcl
module "basic_metastore_data_access" {
  source = "./modules/databricks_metastore_data_access"

  metastore_id        = "12345"
  name                = "azure_mi_access"
  owner               = "admin"
  access_connector_id = "/subscriptions/.../resourceGroups/.../providers/..."
  credential_id       = "managed_identity_credential"
}
```

## Example: Default Access Configuration

```hcl
module "default_metastore_data_access" {
  source = "./modules/databricks_metastore_data_access"

  metastore_id        = "12345"
  name                = "default_azure_mi_access"
  owner               = "admin"
  access_connector_id = "/subscriptions/.../resourceGroups/.../providers/..."
  credential_id       = "managed_identity_credential"
  is_default         = true
  comment            = "Default Azure Managed Identity access for the metastore"
}
```