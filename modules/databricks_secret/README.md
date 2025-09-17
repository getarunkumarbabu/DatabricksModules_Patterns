# Databricks Secret Module

This module manages secrets within a Databricks secret scope, allowing you to securely store and access sensitive information.

## Usage

```hcl
# First create a secret scope
module "secret_scope" {
  source = "./modules/databricks_secret_scope"

  name        = "my-scope"
  initial_manage_principal = "users"
}

# Then add secrets to it
module "secret" {
  source = "./modules/databricks_secret"

  key          = "my-secret-key"
  string_value = var.sensitive_value
  scope        = module.secret_scope.scope_name
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key | The key under which the secret value will be stored | `string` | n/a | yes |
| string_value | The secret value to store | `string` | n/a | yes |
| scope | The name of the secret scope in which to store the secret | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| secret_key | The key of the secret |
| secret_scope | The scope containing the secret |

## Notes

1. The secret scope must exist before creating secrets within it.
2. Secret values are sensitive and will not be displayed in logs or output.
3. Secrets can be accessed in notebooks and jobs using the Databricks Secrets API:
   ```python
   secret_value = dbutils.secrets.get(scope="my-scope", key="my-secret-key")
   ```
4. Secret scopes and secrets are workspace-specific.
5. Secret values cannot be retrieved once stored, only referenced.