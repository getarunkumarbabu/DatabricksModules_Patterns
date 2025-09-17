# Databricks On-Behalf-Of Token Module

This module manages on-behalf-of (OBO) tokens in Databricks, allowing applications to perform actions on behalf of users.

## Features

- Generate on-behalf-of tokens for applications
- Configurable token lifetime
- Optional token comments for tracking
- Secure token value handling

## Usage

```hcl
module "app_token" {
  source = "./modules/databricks_obo_token"

  application_id    = "12345678-1234-5678-1234-567812345678"
  comment          = "Token for data pipeline automation"
  lifetime_seconds = 7200  # 2 hours
}
```

## Examples

### Short-lived Token

```hcl
module "temp_token" {
  source = "./modules/databricks_obo_token"

  application_id    = var.app_id
  comment          = "Temporary access for batch job"
  lifetime_seconds = 1800  # 30 minutes
}
```

### Long-lived Token

```hcl
module "service_token" {
  source = "./modules/databricks_obo_token"

  application_id    = var.service_app_id
  comment          = "Service integration token"
  lifetime_seconds = 86400  # 24 hours
}
```

## Requirements

- Databricks provider configured with workspace access
- Valid application registration in Azure AD
- Appropriate permissions to generate OBO tokens

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| application_id | The application ID for which to generate the token | `string` | n/a | yes |
| comment | Comment describing the purpose of the token | `string` | `null` | no |
| lifetime_seconds | The lifetime of the token in seconds | `number` | `3600` | no |

## Outputs

| Name | Description |
|------|-------------|
| token_value | The generated token value (sensitive) |
| token_id | The unique identifier for the token |
| creation_time | The timestamp when the token was created |
| expiry_time | The timestamp when the token will expire |
| token_info | The complete token information excluding sensitive data |

## Notes

1. Token values are sensitive and should be handled securely
2. Maximum token lifetime is 864000 seconds (10 days)
3. Tokens cannot be renewed; generate new tokens before expiry
4. Use the shortest practical lifetime for security

## Best Practices

1. Use meaningful comments for token tracking
2. Implement token rotation mechanisms
3. Use short token lifetimes when possible
4. Store token values securely
5. Monitor token usage and expiration