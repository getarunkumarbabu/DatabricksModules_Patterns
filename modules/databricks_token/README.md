# Databricks Token Module

This module manages personal access tokens in Databricks using the `databricks_token` resource.

## Inputs

- `comment` (string) - Comment describing the purpose of the token
- `lifetime_seconds` (number, optional) - Lifetime of the token in seconds. If not specified, token never expires

## Outputs

- `token_id` - ID of the created token
- `token_value` - Token value (sensitive)

## Example

```hcl
module "service_token" {
  source = "../modules/databricks_token"
  
  comment          = "Token for CI/CD pipeline"
  lifetime_seconds = 7776000  # 90 days
}
```

## Security Notes

- Token values are sensitive and will be stored in Terraform state
- Consider using shorter lifetimes for tokens and rotating them regularly
- Use RBAC to control token permissions
- Consider using service principals instead of tokens for service authentication