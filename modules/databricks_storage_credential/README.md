# Databricks Storage Credential Module

This module creates and manages storage credentials in Databricks Unity Catalog. Storage credentials are used to authenticate access to external storage locations.

## Usage

```hcl
# AWS IAM Role example
module "aws_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "aws-storage-cred"
  aws_iam_role = {
    role_arn = "arn:aws:iam::123456789012:role/my-storage-role"
  }
}

# Azure Managed Identity example
module "azure_mi_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "azure-mi-cred"
  azure_managed_identity = {
    access_connector_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Databricks/accessConnectors/my-connector"
  }
}

# Azure Service Principal example
module "azure_sp_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "azure-sp-cred"
  azure_service_principal = {
    directory_id   = "tenant-id"
    application_id = "app-id"
    client_secret  = "client-secret"
  }
}

# GCP Service Account example
module "gcp_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "gcp-sa-cred"
  databricks_gcp_service_account = {
    email = "my-service-account@project.iam.gserviceaccount.com"
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
| name | Name of storage credential | string | n/a | yes |
| comment | Comment describing the credential | string | null | no |
| owner | Username/GroupName/ServicePrincipal of the credential owner | string | null | no |
| aws_iam_role | AWS IAM role configuration | object | null | no |
| azure_managed_identity | Azure managed identity configuration | object | null | no |
| azure_service_principal | Azure service principal configuration | object | null | no |
| databricks_gcp_service_account | GCP service account configuration | object | null | no |
| force_destroy | Delete credential regardless of dependencies | bool | false | no |
| force_update | Force update even if credential is used by external locations | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_credential_id | ID of the created storage credential |
| storage_credential_name | Name of the created storage credential |
| owner | Owner of the storage credential |