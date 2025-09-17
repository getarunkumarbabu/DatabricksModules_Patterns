# Azure Databricks External Location Module

This module manages Azure Storage locations in Unity Catalog, allowing secure access to Azure Data Lake Storage Gen2 containers as external data sources. It integrates with Azure storage credentials and provides fine-grained access control.

## Features

- Azure Data Lake Storage Gen2 integration
- Service Principal or Managed Identity authentication
- Path-level access control
- Read/write or read-only access modes
- Unity Catalog integration
- Azure-specific storage optimizations

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |
| azurerm | >= 3.0.0 |

## Azure Prerequisites

1. Azure Storage Configuration:
   - Storage Account with Hierarchical Namespace enabled
   - Container created and configured
   - Network access rules set up
   - Optional: Private Endpoints configured

2. Storage Credential Setup:
   ```hcl
   resource "databricks_storage_credential" "azure" {
     name = "azure_storage_cred"
     azure_managed_identity {
       access_connector_id = azurerm_databricks_access_connector.this.id
     }
   }
   ```

3. Required Azure Permissions:
   - Storage Blob Data Contributor/Reader roles
   - Unity Catalog admin privileges
   - Azure RBAC permissions

## Usage Examples

### Basic External Location with Service Principal

```hcl
module "data_lake_location" {
  source = "./modules/databricks_external_location"

  name            = "data_lake"
  url             = "abfss://data@mystorageacct.dfs.core.windows.net/external"
  credential_name = "azure_storage_cred"
  comment         = "Data lake external storage for analytics"
  owner           = "unity.admin@example.com"
}
```

### Read-Only Data Source

```hcl
module "reference_data" {
  source = "./modules/databricks_external_location"

  name            = "reference_data"
  url             = "abfss://reference@mystorageacct.dfs.core.windows.net/master-data"
  credential_name = "azure_storage_cred"
  read_only      = true
  comment         = "Read-only reference data source"
}
```

### Advanced Configuration

```hcl
module "secured_location" {
  source = "./modules/databricks_external_location"

  name            = "secured_analytics"
  url             = "abfss://secured@mystorageacct.dfs.core.windows.net/sensitive"
  credential_name = "azure_storage_cred"
  owner           = "data.security@example.com"
  read_only      = true
  skip_validation = false
  
  comment = jsonencode({
    purpose     = "Sensitive data analysis"
    owner_team  = "Data Security"
    compliance  = "GDPR"
    encryption  = "CMK"
    access_mode = "read-only"
  })
}
```

## Security Best Practices

1. Storage Access:
   - Use minimum required permissions
   - Enable diagnostic logging
   - Implement network isolation
   - Use Private Endpoints where possible

2. Authentication:
   - Prefer Managed Identity over Service Principal
   - Regular credential rotation
   - Use Azure Key Vault for secrets

3. Access Control:
   - Implement read-only where possible
   - Use path-level restrictions
   - Regular access audits
   - Monitor usage patterns

## Location Patterns

1. Data Lake Organization:
```
abfss://container@storage.dfs.core.windows.net/
├── raw/
│   ├── source1/
│   └── source2/
├── processed/
│   ├── daily/
│   └── historical/
└── curated/
    ├── analytics/
    └── ml-features/
```

2. Security Zones:
```
abfss://data@storage.dfs.core.windows.net/
├── public/
├── internal/
└── confidential/
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | External location name in Unity Catalog | string | yes |
| url | ABFS URL for Azure storage location | string | yes |
| credential_name | Azure storage credential name | string | yes |
| comment | Description and metadata | string | no |
| owner | Azure AD identity for ownership | string | no |
| read_only | Read-only access mode flag | bool | no |
| skip_validation | Skip access validation flag | bool | no |

## Outputs

| Name | Description |
|------|-------------|
| external_location_id | Unity Catalog location ID |
| external_location_name | Location name |
| storage_location | Azure storage details |
| external_location_config | Complete configuration |
| access_url | DBFS access path |

## Notes

- Changes may require Unity Catalog admin privileges
- Storage access requires proper Azure RBAC
- Use diagnostic logging for access tracking
- Consider data lifecycle management
- Monitor storage costs and usage