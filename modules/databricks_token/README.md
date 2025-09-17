# Databricks Token Module for Azure

This module manages personal access tokens in Azure Databricks using the `databricks_token` resource. While tokens are platform-agnostic, this documentation focuses on Azure Databricks best practices and security recommendations.

## Features

- Personal access token generation and management
- Configurable token lifetime for security
- Integration with Azure Databricks SCIM provisioning
- Compatible with Azure Databricks workspace access control

## Authentication Hierarchy in Azure Databricks

1. **Azure AD Service Principals (Recommended)**
   - Best for service-to-service authentication
   - Integrated with Azure RBAC
   - Supports Managed Identities
   - Audit trail in Azure AD

2. **Personal Access Tokens (PAT)**
   - Best for development and testing
   - Useful for CI/CD pipelines
   - Direct API authentication
   - Workspace-level scope

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| comment | Comment describing the purpose of the token | string | n/a | yes |
| lifetime_seconds | Lifetime of the token in seconds. If not specified, token never expires | number | null | no |

## Outputs

| Name | Description |
|------|-------------|
| token_id | ID of the created token |
| token_value | Token value (sensitive) |

## Usage Examples

### Development Token
```hcl
module "dev_token" {
  source = "../modules/databricks_token"
  
  comment          = "Development environment access"
  lifetime_seconds = 604800  # 7 days
}
```

### CI/CD Pipeline Token
```hcl
module "cicd_token" {
  source = "../modules/databricks_token"
  
  comment          = "Azure DevOps pipeline access"
  lifetime_seconds = 7776000  # 90 days
}
```

### Short-lived Token for Testing
```hcl
module "test_token" {
  source = "../modules/databricks_token"
  
  comment          = "Integration test token"
  lifetime_seconds = 3600  # 1 hour
}
```

## Azure Security Best Practices

1. **Token Lifecycle Management**
   - Use short-lived tokens when possible
   - Implement automated token rotation
   - Monitor token usage and expiration
   - Clean up unused tokens promptly

2. **Access Control**
   - Integrate with Azure AD groups for token management
   - Use Azure RBAC for token permissions
   - Apply principle of least privilege
   - Regularly audit token access

3. **Service Authentication**
   - Prefer Azure AD service principals over PAT for services
   - Use Managed Identities where possible
   - Consider Azure Key Vault for token storage
   - Enable Azure AD Conditional Access policies

4. **Monitoring and Compliance**
   - Enable Azure Monitor for token usage
   - Set up alerts for token creation/deletion
   - Track token usage in Azure Activity Logs
   - Maintain compliance with token policies

## Security Considerations

1. **Token Storage**
   - Token values are sensitive and stored in Terraform state
   - Use remote state with encryption
   - Consider Azure Key Vault for token storage
   - Implement proper state file access controls

2. **Token Permissions**
   - Scope tokens to minimum required permissions
   - Use Azure RBAC to control token creation
   - Implement token creation approval process
   - Monitor token usage patterns

3. **Token Rotation**
   - Implement automated token rotation
   - Use shorter token lifetimes
   - Plan for token expiration handling
   - Maintain token inventory

4. **Compliance**
   - Follow Azure security baselines
   - Implement token usage auditing
   - Maintain token creation records
   - Regular security reviews

## Alternative Authentication Methods

Consider these Azure-native alternatives to tokens:

1. **Azure AD Service Principals**
   - Preferred for service authentication
   - Better audit capabilities
   - Integration with Azure RBAC
   - Support for certificate auth

2. **Managed Identities**
   - No credential management
   - Azure-managed security
   - Automatic credential rotation
   - Simplified configuration

3. **Azure AD Application Registration**
   - OAuth 2.0 support
   - Multi-tenant scenarios
   - Custom application roles
   - Enhanced security features

## Notes

- Always use the shortest viable token lifetime
- Store tokens securely using Azure Key Vault
- Monitor token usage through Azure Monitor
- Consider Azure AD service principals for production services
- Implement proper token revocation procedures
- Follow Azure security best practices for access management