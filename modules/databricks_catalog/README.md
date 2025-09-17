# Azure Databricks Unity Catalog Module

This module manages Unity Catalog catalogs in Azure Databricks. Catalogs are top-level containers for organizing data assets in Unity Catalog, providing a hierarchical namespace for databases, tables, and views. This module supports both managed and external catalogs with comprehensive configuration options for Azure.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |

## Usage Examples

### Basic Managed Catalog

```hcl
module "managed_catalog" {
  source = "./modules/databricks_catalog"

  name    = "data_science_catalog"
  comment = "Catalog for data science workloads"
  owner   = "data.science@company.com"
  
  properties = {
    environment = "production"
    team        = "data_science"
    cost_center = "ds001"
  }
  
  tags = {
    purpose     = "machine_learning"
    compliance  = "hipaa"
  }
}
```

### External Catalog with Azure Data Lake Storage Gen2

```hcl
module "external_catalog" {
  source = "./modules/databricks_catalog"

  name         = "external_data"
  comment      = "External catalog for raw data lake storage"
  owner        = "data.platform@company.com"
  
  isolation_mode = "ISOLATED"
  provider_name  = "azure"
  storage_root   = "abfss://container@storageaccount.dfs.core.windows.net/path"
  
  properties = {
    environment = "production"
    data_tier   = "raw"
    storage_account = "storageaccount"
    container = "container"
  }
}
```

### Advanced Catalog with Azure-Specific Settings

```hcl
module "advanced_catalog" {
  source = "./modules/databricks_catalog"

  name           = "finance_data"
  comment        = "Restricted catalog for financial data"
  owner          = "finance.team@company.com"
  isolation_mode = "ISOLATED"
  provider_name  = "azure"
  storage_root   = "abfss://finance@datastore.dfs.core.windows.net/sensitive"
  
  properties = {
    department      = "finance"
    business_unit   = "corporate"
    data_owner      = "finance.lead@company.com"
    retention_days  = "90"
    encryption_type = "azure-cmk"  # Customer-managed key
  }
  
  tags = {
    compliance = "sox"
    security   = "high"
    pii        = "true"
  }
}
```

## Catalog Types

### Managed Catalogs
- Default catalog type using Databricks-managed storage in Azure
- Automatically handles data storage and metadata
- Ideal for most use cases where direct storage control isn't needed
- Encrypted at rest using Azure-managed keys

### External Catalogs
- Points to external Azure Data Lake Storage Gen2 containers
- Requires storage_root with ABFS URL and azure provider configuration
- Enables direct data lake integration and custom storage solutions
- Supports Azure storage features like customer-managed keys and soft delete

## Required Azure Configuration

### 1. Azure Storage Account Setup
- Create a Storage Account with Hierarchical Namespace enabled (ADLS Gen2)
- Configure networking settings (firewall, private endpoints if needed)
- Set up lifecycle management policies if required
- Optional: Configure customer-managed keys for encryption

### 2. Service Principal Configuration
```bash
# Create service principal and assign roles
az ad sp create-for-rbac --name "databricks-catalog-sp" --role "Storage Blob Data Contributor" --scopes "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account-name>"

# Add additional role for secure access
az role assignment add --assignee "<service-principal-id>" --role "Storage Blob Data Reader" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account-name>"
```

### 3. Azure Storage Access Configuration
1. Enable Hierarchical Namespace
2. Configure network access:
   - Allow Azure services
   - Add Databricks VNet if using private endpoints
3. Set up CORS if needed for web access
4. Configure diagnostic settings

### 4. Security Best Practices
- Use Azure Private Link when possible
- Enable Soft Delete for data protection
- Implement Azure Policy for compliance
- Use service principal with minimum required permissions
- Enable Azure Defender for Storage

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Catalog name. Must be unique within workspace. Allows alphanumeric characters, underscores, and dots. | `string` | n/a | yes |
| comment | Description documenting the catalog's purpose and contents | `string` | `null` | no |
| properties | Key-value pairs for catalog properties (environment, team, etc.) | `map(string)` | `{}` | no |
| tags | Organization and governance tags | `map(string)` | `{}` | no |
| owner | Catalog owner (user, group, or service principal) | `string` | `null` | no |
| isolation_mode | Access control mode (OPEN or ISOLATED) | `string` | `"OPEN"` | no |
| provider_name | Storage provider for external catalogs (azure) | `string` | `null` | no |
| storage_root | Storage root URL for external catalogs | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| catalog_id | Unique identifier of the catalog |
| catalog_name | Name of the catalog |
| full_name | Fully qualified catalog name |
| owner | Catalog owner |
| metadata | Creation and update metadata |
| properties | Combined properties and tags |
| isolation_mode | Catalog isolation mode |
| provider_details | External storage provider details |
| catalog | Complete catalog resource |

## Best Practices

### Naming Conventions
- Use consistent, descriptive names
- Include business unit or team identifier
- Consider environment or purpose prefixes
- Examples: `finance_prod`, `ds_sandbox`, `marketing_external`

### Access Control
1. Use ISOLATED mode for sensitive data
2. Assign specific owners rather than generic accounts
3. Document ownership in properties
4. Consider separation of duties

### Properties and Tags
1. Standardize property keys across catalogs
2. Include:
   - Environment
   - Business unit/team
   - Cost center
   - Data classification
   - Compliance requirements

### External Catalogs
1. Verify storage permissions
2. Document storage location
3. Consider regional constraints
4. Implement proper monitoring

## Catalog Management

### Creation
```hcl
module "new_catalog" {
  source = "./modules/databricks_catalog"
  
  name    = "new_catalog"
  comment = "Purpose of this catalog"
  owner   = "owner@company.com"
  
  properties = {
    key = "value"
  }
}
```

### Migration
When migrating data between catalogs:
1. Create destination catalog
2. Transfer data
3. Validate permissions
4. Update references

### Deletion
Catalogs containing data cannot be deleted unless:
1. All data is removed, or
2. force_destroy is set (not recommended for production)

## Monitoring and Maintenance

### Key Metrics
- Usage patterns
- Access logs
- Storage utilization
- Permission changes

### Regular Tasks
1. Review permissions
2. Audit properties
3. Update documentation
4. Validate external connections

## Troubleshooting

### Common Issues

1. Permission Errors
   - Verify owner exists
   - Check isolation mode
   - Validate storage permissions

2. External Storage
   - Validate storage_root URL
   - Check provider configuration
   - Verify network access

3. Name Conflicts
   - Check for existing catalogs
   - Verify naming conventions
   - Consider namespacing

### Support Resources

For issues or questions:
1. Check Databricks documentation
2. Review Unity Catalog guides
3. Contact Databricks support
4. Review terraform logs