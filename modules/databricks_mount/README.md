# Azure Databricks Mount Module

This module manages Azure Data Lake Storage Gen2 (ADLS Gen2) mounts in Azure Databricks using ABFS (Azure Blob File System) protocol. It provides secure and efficient data access between Databricks workspaces and Azure Storage.

## Features

- ADLS Gen2 integration using ABFS protocol
- Support for both Service Principal and Managed Identity authentication
- Secure credential management
- Optional directory-level mounting
- Configurable storage access patterns
- Azure-specific optimizations

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |
| azurerm | >= 3.0.0 |

## Azure Prerequisites

1. Storage Account Configuration:
   - Enable hierarchical namespace for ADLS Gen2
   - Configure appropriate network access
   - Set up CORS if needed

2. Authentication Setup:
   ```bash
   # Create service principal (if using SERVICE_PRINCIPAL auth)
   az ad sp create-for-rbac --name "databricks-mount-sp" --role "Storage Blob Data Contributor" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account>"
   ```

3. Required Permissions:
   - Storage Blob Data Contributor role on the container
   - Storage Blob Data Reader (minimum) for read-only access

## Usage Examples

### Basic Mount with Service Principal Auth

```hcl
module "data_mount" {
  source = "./modules/databricks_mount"

  name                = "raw_data"
  container_name      = "data"
  storage_account_name = "mystorageaccount"
  uri                 = "abfss://data@mystorageaccount.dfs.core.windows.net/"
  
  auth_type          = "SERVICE_PRINCIPAL"
  tenant_id          = "00000000-0000-0000-0000-000000000000"
  client_id          = "11111111-1111-1111-1111-111111111111"
  client_secret      = var.storage_client_secret
}
```

### Mount with Managed Identity

```hcl
module "secure_mount" {
  source = "./modules/databricks_mount"

  name                = "secure_data"
  container_name      = "sensitive"
  storage_account_name = "securestorage"
  uri                 = "abfss://sensitive@securestorage.dfs.core.windows.net/finance"
  directory           = "/finance"
  
  auth_type          = "MANAGED_IDENTITY"
}
```

### Mount with Advanced Configuration

```hcl
module "optimized_mount" {
  source = "./modules/databricks_mount"

  name                = "analytics_data"
  container_name      = "analytics"
  storage_account_name = "analyticsstorage"
  uri                 = "abfss://analytics@analyticsstorage.dfs.core.windows.net/"
  
  auth_type          = "SERVICE_PRINCIPAL"
  tenant_id          = var.tenant_id
  client_id          = var.client_id
  client_secret      = var.client_secret

  extra_config = {
    # Performance optimization
    "fs.azure.io.readahead.enabled" = "true"
    "fs.azure.readahead.size" = "4194304"
    
    # Retry configuration
    "fs.azure.retry.limit" = "10"
    "fs.azure.retry.interval" = "1000"
    
    # Connection settings
    "fs.azure.connection.timeout" = "300000"
    "fs.azure.write.request.size" = "10485760"
  }
}
```

## Security Best Practices

1. Service Principal Authentication:
   - Use minimal required permissions
   - Rotate client secrets regularly
   - Store secrets in Azure Key Vault

2. Managed Identity Authentication:
   - Prefer when possible for enhanced security
   - Configure proper RBAC assignments
   - Use separate managed identities for different purposes

3. Network Security:
   - Use private endpoints when possible
   - Configure storage firewall rules
   - Enable secure transfer (HTTPS)

4. Mount Configuration:
   - Mount at specific directories when possible
   - Use read-only mounts when write access isn't needed
   - Configure appropriate timeouts and retry policies

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | The name of the mount point in DBFS | string | yes |
| container_name | The name of the Azure Storage container to mount | string | yes |
| storage_account_name | The name of the Azure Storage account | string | yes |
| uri | The ABFS URI for the Azure Storage mount point | string | yes |
| directory | Directory within the container to mount | string | no |
| auth_type | Authentication type (SERVICE_PRINCIPAL or MANAGED_IDENTITY) | string | no |
| tenant_id | Azure AD tenant ID (required for SERVICE_PRINCIPAL) | string | no |
| client_id | Azure AD client ID (required for SERVICE_PRINCIPAL) | string | no |
| client_secret | Azure AD client secret (required for SERVICE_PRINCIPAL) | string | no |
| extra_config | Additional configuration options | map(string) | no |

## Outputs

| Name | Description |
|------|-------------|
| mount_id | The ID of the mount |
| mount_url | The DBFS URL for the mount point |
| mount | The full mount resource |

## Notes

1. The mount point will be accessible at `/mnt/<name>` in DBFS
2. Make sure the proper Azure authentication is configured using either:
   - Service Principal with appropriate permissions
   - Managed Identity with correct role assignments
3. Mount points are workspace-specific
4. Consider using Azure Private Endpoints for enhanced security

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |
| azurerm | >= 3.0.0 |

## Azure Prerequisites

1. Storage Account Configuration:
   - Enable hierarchical namespace for ADLS Gen2
   - Configure appropriate network access
   - Set up CORS if needed

2. Authentication Setup:
   ```bash
   # Create service principal (if using SERVICE_PRINCIPAL auth)
   az ad sp create-for-rbac --name "databricks-mount-sp" --role "Storage Blob Data Contributor" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account>"
   ```

3. Required Permissions:
   - Storage Blob Data Contributor role on the container
   - Storage Blob Data Reader (minimum) for read-only access

## Usage Examples

### Basic Mount with Service Principal Auth

```hcl
module "data_mount" {
  source = "./modules/databricks_mount"

  name                = "raw_data"
  container_name      = "data"
  storage_account_name = "mystorageaccount"
  uri                 = "abfss://data@mystorageaccount.dfs.core.windows.net/"
  
  auth_type          = "SERVICE_PRINCIPAL"
  tenant_id          = "00000000-0000-0000-0000-000000000000"
  client_id          = "11111111-1111-1111-1111-111111111111"
  client_secret      = var.storage_client_secret
}
```

### Mount with Managed Identity

```hcl
module "secure_mount" {
  source = "./modules/databricks_mount"

  name                = "secure_data"
  container_name      = "sensitive"
  storage_account_name = "securestorage"
  uri                 = "abfss://sensitive@securestorage.dfs.core.windows.net/finance"
  directory           = "/finance"
  
  auth_type          = "MANAGED_IDENTITY"
}
```

### Mount with Advanced Configuration

```hcl
module "optimized_mount" {
  source = "./modules/databricks_mount"

  name                = "analytics_data"
  container_name      = "analytics"
  storage_account_name = "analyticsstorage"
  uri                 = "abfss://analytics@analyticsstorage.dfs.core.windows.net/"
  
  auth_type          = "SERVICE_PRINCIPAL"
  tenant_id          = var.tenant_id
  client_id          = var.client_id
  client_secret      = var.client_secret

  extra_config = {
    # Performance optimization
    "fs.azure.io.readahead.enabled" = "true"
    "fs.azure.readahead.size" = "4194304"
    
    # Retry configuration
    "fs.azure.retry.limit" = "10"
    "fs.azure.retry.interval" = "1000"
    
    # Connection settings
    "fs.azure.connection.timeout" = "300000"
    "fs.azure.write.request.size" = "10485760"
  }
}
```

## Security Best Practices

1. Service Principal Authentication:
   - Use minimal required permissions
   - Rotate client secrets regularly
   - Store secrets in Azure Key Vault

2. Managed Identity Authentication:
   - Prefer when possible for enhanced security
   - Configure proper RBAC assignments
   - Use separate managed identities for different purposes

3. Network Security:
   - Use private endpoints when possible
   - Configure storage firewall rules
   - Enable secure transfer (HTTPS)

4. Mount Configuration:
   - Mount at specific directories when possible
   - Use read-only mounts when write access isn't needed
   - Configure appropriate timeouts and retry policies

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | The name of the mount point in DBFS | string | yes |
| container_name | The name of the Azure Storage container to mount | string | yes |
| storage_account_name | The name of the Azure Storage account | string | yes |
| uri | The ABFS URI for the Azure Storage mount point | string | yes |
| directory | Directory within the container to mount | string | no |
| auth_type | Authentication type (SERVICE_PRINCIPAL or MANAGED_IDENTITY) | string | no |
| tenant_id | Azure AD tenant ID (required for SERVICE_PRINCIPAL) | string | no |
| client_id | Azure AD client ID (required for SERVICE_PRINCIPAL) | string | no |
| client_secret | Azure AD client secret (required for SERVICE_PRINCIPAL) | string | no |
| extra_config | Additional configuration options | map(string) | no |
  auth_type           = string
  tenant_id           = optional(string)
  client_id           = optional(string)
  client_secret       = optional(string)
})
```

### GCP Configuration

```hcl
object({
  bucket_name     = string
  service_account = string
})
```

## Outputs

| Name | Description |
|------|-------------|
| mount_id | The ID of the mount |
| mount_url | The DBFS URL for the mount point |
| mount | The full mount resource |

## Notes

1. Only one cloud provider configuration (s3_config, azure_config, or gcp_config) should be specified.
2. The mount point will be accessible at `/mnt/<name>` in DBFS.
3. Make sure the necessary authentication is configured:
   - For AWS: Instance profile or IAM role
   - For Azure: Service principal or managed identity
   - For GCP: Service account
4. Mount points are workspace-specific.