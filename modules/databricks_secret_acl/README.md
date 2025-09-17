# Databricks Secret ACL Module

This module manages access control lists (ACLs) for Databricks secret scopes, allowing fine-grained control over who can access secrets.

## Features

- Manage secret scope permissions
- Support for users, service principals, and groups
- Three permission levels: READ, WRITE, and MANAGE
- Fine-grained access control

## Usage

```hcl
module "secret_acl" {
  source = "./modules/databricks_secret_acl"

  principal  = "user@example.com"
  scope     = "my-secret-scope"
  permission = "READ"
}
```

## Examples

### Read Access for User

```hcl
module "user_secret_access" {
  source = "./modules/databricks_secret_acl"

  principal  = "john.doe@company.com"
  scope     = "production-secrets"
  permission = "READ"
}
```

### Write Access for Service Principal

```hcl
module "service_secret_access" {
  source = "./modules/databricks_secret_acl"

  principal  = var.service_principal_application_id
  scope     = "automation-secrets"
  permission = "WRITE"
}
```

### Management Access for Admin Group

```hcl
module "admin_secret_access" {
  source = "./modules/databricks_secret_acl"

  principal  = databricks_group.secret_admins.id
  scope     = "shared-secrets"
  permission = "MANAGE"
}
```

## Requirements

- Databricks provider configured with workspace access
- Existing secret scope
- Appropriate permissions to manage secret ACLs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| principal | The principal to grant permissions to | `string` | n/a | yes |
| scope | The name of the secret scope | `string` | n/a | yes |
| permission | The permission level (READ/WRITE/MANAGE) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acl_id | The unique identifier for the secret ACL |
| principal | The principal granted permissions |
| scope | The secret scope name |
| permission | The granted permission level |

## Notes

1. Permission levels:
   - READ: View secret values
   - WRITE: Create and modify secrets
   - MANAGE: Full control including ACL management
2. Secret scopes must exist before creating ACLs
3. Principals must exist and be valid
4. Changes to ACLs take effect immediately

## Best Practices

1. Follow principle of least privilege
2. Regularly audit secret access
3. Use groups for easier management
4. Document access grants
5. Prefer READ access when possible