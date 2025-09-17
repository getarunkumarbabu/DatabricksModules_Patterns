# Databricks Storage Credential Module for Azure

This module creates and manages Azure storage credentials in Databricks Unity Catalog. The module is specifically designed for Azure Databricks environments and supports both Azure Managed Identity and Service Principal authentication methods for accessing Azure storage.

## Features

- Azure Managed Identity support for secure, managed authentication
- Azure Service Principal support for traditional authentication
- Built-in validation for Azure resource IDs and GUIDs
- Integration with Azure Databricks Unity Catalog
- Support for credential ownership and access management

## Usage

```hcl
# Azure Managed Identity example
module "azure_mi_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "azure-mi-cred"
  azure_managed_identity = {
    access_connector_id = "/subscriptions/12345678-1234-5678-abcd-1234567890ab/resourceGroups/my-rg/providers/Microsoft.Databricks/accessConnectors/my-connector"
  }
}

# Azure Service Principal example
module "azure_sp_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name = "azure-sp-cred"
  azure_service_principal = {
    directory_id   = "12345678-1234-5678-abcd-1234567890ab" # Azure AD tenant ID
    application_id = "87654321-4321-8765-dcba-0987654321fe" # Azure AD application ID
    client_secret  = "your-client-secret"
  }
}

# With additional configurations
module "azure_storage_credential" {
  source = "./modules/databricks_storage_credential"

  name     = "azure-storage-cred"
  comment  = "Storage credential for data lake access"
  owner    = "admins"
  
  azure_managed_identity = {
    access_connector_id = "/subscriptions/.../accessConnectors/my-connector"
  }
  
  force_update = true # Use with caution
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |
| azurerm | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of storage credential | string | n/a | yes |
| comment | Comment describing the credential | string | null | no |
| owner | Username/GroupName/ServicePrincipal of the credential owner | string | null | no |
| azure_managed_identity | Azure managed identity configuration. Requires Azure Databricks Premium tier. | object({access_connector_id = string}) | null | no |
| azure_service_principal | Azure service principal configuration | object({directory_id = string, application_id = string, client_secret = string}) | null | no |
| force_destroy | Delete credential regardless of dependencies | bool | false | no |
| force_update | Force update even if credential is used by external locations | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_credential_id | ID of the created storage credential |
| storage_credential_name | Name of the created storage credential |
| owner | Owner of the storage credential |

## Authentication Methods

### Azure Managed Identity (Recommended)
Uses Azure Databricks-managed identity to access storage. This is the most secure option as it:
- Eliminates credential management
- Supports automatic credential rotation
- Integrates with Azure RBAC
- Requires Azure Databricks Premium tier

### Azure Service Principal
Uses an Azure AD application for authentication. Consider this when:
- Using Azure Databricks Standard tier
- Requiring fine-grained access control
- Needing cross-tenant access
- Implementing custom credential rotation

## Best Practices

1. Always use Managed Identity when possible
2. Implement least-privilege access
3. Regularly rotate service principal credentials
4. Use descriptive names and comments
5. Consider using tags for better organization
6. Keep credential access audit logs
7. Monitor credential usage

## Notes

- Only one authentication method can be used per credential
- Managed Identity requires Azure Databricks Premium tier
- Service Principal credentials should be stored securely
- Use force_update with caution as it may impact running workloads