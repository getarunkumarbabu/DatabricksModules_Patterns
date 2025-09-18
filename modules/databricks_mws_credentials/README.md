# Databricks MWS Credentials Module

This module manages credentials for Azure Databricks workspace creation at the account level. It sets up service principal authentication for workspace management.

## Usage

```hcl
module "databricks_credentials" {
  source = "./modules/databricks_mws_credentials"

  account_id       = "123456789"
  credentials_name = "azure-sp-credentials"
  
  application_id = "00000000-0000-0000-0000-000000000000"
  client_secret  = var.service_principal_secret
  directory_id   = "11111111-1111-1111-1111-111111111111"
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
| credentials_name | Name for the credentials | `string` | n/a | yes |
| application_id | Azure service principal application ID | `string` | n/a | yes |
| client_secret | Azure service principal client secret | `string` | n/a | yes |
| directory_id | Azure directory (tenant) ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| credentials_id | ID of the created credentials |
| creation_time | Time when the credentials were created |

## Example: Basic Configuration

```hcl
module "databricks_credentials_basic" {
  source = "./modules/databricks_mws_credentials"

  account_id       = var.databricks_account_id
  credentials_name = "workspace-sp"
  
  application_id = azuread_application.example.application_id
  client_secret  = azuread_service_principal_password.example.value
  directory_id   = data.azurerm_client_config.current.tenant_id
}
```

## Example: With Azure Key Vault Integration

```hcl
data "azurerm_key_vault_secret" "sp_secret" {
  name         = "databricks-sp-secret"
  key_vault_id = azurerm_key_vault.example.id
}

module "databricks_credentials_secure" {
  source = "./modules/databricks_mws_credentials"

  account_id       = var.databricks_account_id
  credentials_name = "workspace-sp-secure"
  
  application_id = azuread_application.example.application_id
  client_secret  = data.azurerm_key_vault_secret.sp_secret.value
  directory_id   = data.azurerm_client_config.current.tenant_id
}
```