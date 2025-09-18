# Databricks Customer Managed Keys Module

This module manages customer-managed keys (CMK) for Azure Databricks using Azure Key Vault. It allows you to configure encryption keys for various Databricks services.

## Usage

```hcl
module "databricks_cmk" {
  source = "./modules/databricks_mws_customer_managed_keys"

  account_id          = "123456789"
  access_connector_id = "/subscriptions/.../resourceGroups/.../providers/..."
  credential_id      = "managed-identity-credential"
  
  use_cases = ["MANAGED_SERVICES", "STORAGE"]
  
  key_info = {
    key_vault_uri = "https://your-keyvault.vault.azure.net/"
    key_name      = "databricks-cmk"
    key_version   = "current"  # Optional
  }
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
| access_connector_id | Azure managed identity access connector ID | `string` | n/a | yes |
| credential_id | Azure managed identity credential ID | `string` | n/a | yes |
| use_cases | List of use cases for customer managed keys | `list(string)` | n/a | yes |
| key_info | Azure Key Vault key information | `object` | `null` | no |

### key_info Object Structure

```hcl
object({
  key_vault_uri = string
  key_name      = string
  key_version   = optional(string)
})
```

## Outputs

| Name | Description |
|------|-------------|
| customer_managed_key_id | ID of the customer managed key configuration |
| use_cases | List of use cases for the customer managed keys |
| key_info | Azure Key Vault key information |

## Example: Basic Configuration

```hcl
module "databricks_cmk_basic" {
  source = "./modules/databricks_mws_customer_managed_keys"

  account_id          = var.databricks_account_id
  access_connector_id = azurerm_databricks_access_connector.example.id
  credential_id      = databricks_mws_credentials.this.credential_id
  
  use_cases = ["MANAGED_SERVICES"]
  
  key_info = {
    key_vault_uri = azurerm_key_vault.example.vault_uri
    key_name      = azurerm_key_vault_key.example.name
  }
}
```

## Example: Multiple Use Cases

```hcl
module "databricks_cmk_multi" {
  source = "./modules/databricks_mws_customer_managed_keys"

  account_id          = var.databricks_account_id
  access_connector_id = azurerm_databricks_access_connector.example.id
  credential_id      = databricks_mws_credentials.this.credential_id
  
  use_cases = [
    "MANAGED_SERVICES",
    "STORAGE",
    "WORKSPACE"
  ]
  
  key_info = {
    key_vault_uri = azurerm_key_vault.example.vault_uri
    key_name      = azurerm_key_vault_key.example.name
    key_version   = azurerm_key_vault_key.example.version
  }
}
```