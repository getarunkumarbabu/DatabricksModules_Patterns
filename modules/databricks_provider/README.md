# Databricks Provider Module

This module manages Delta Sharing providers in Databricks, allowing you to configure external data providers.

## Usage

```hcl
# Example with token-based authentication
module "token_provider" {
  source = "./modules/databricks_provider"

  name                = "external-provider"
  comment             = "External data provider configuration"
  authentication_type = "TOKEN"
  
  recipient_profile_str = jsonencode({
    shareCredentialsVersion = 1
    endpoint               = "https://sharing.provider.com"
    bearerToken           = "your-token"
  })
  
  delta_sharing_scope = {
    scope = "ALL_PRIVILEGES"
  }
  
  token = "provider-auth-token"
}

# Example with OAuth authentication
module "oauth_provider" {
  source = "./modules/databricks_provider"

  name                = "oauth-provider"
  comment             = "OAuth-based data provider"
  authentication_type = "OAUTH"
  
  recipient_profile_str = jsonencode({
    shareCredentialsVersion = 1
    endpoint               = "https://sharing.provider.com"
    oauth2 = {
      clientId     = "client-id"
      clientSecret = "client-secret"
      scope        = "read:data"
    }
  })
  
  delta_sharing_scope = {
    scope = "READ_ONLY"
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
| name | Name of the provider | string | n/a | yes |
| comment | Comment describing the provider | string | null | no |
| authentication_type | Authentication type (TOKEN or OAUTH) | string | n/a | yes |
| recipient_profile_str | Recipient profile config in JSON | string | n/a | yes |
| token | Auth token for TOKEN type | string | null | no |
| delta_sharing_scope | Delta sharing scope config | object | null | no |

## Outputs

| Name | Description |
|------|-------------|
| provider_id | ID of the created provider |
| provider_name | Name of the provider |
| profile_str | Recipient profile configuration |

## Notes

- Choose between TOKEN and OAUTH authentication
- Properly structure recipient_profile_str JSON
- Consider security when handling tokens
- Use appropriate sharing scope
- Monitor provider connections
- Keep authentication credentials secure