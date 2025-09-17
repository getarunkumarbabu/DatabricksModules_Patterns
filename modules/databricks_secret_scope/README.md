# Databricks Secret Scope Module

Creates a `databricks_secret_scope` and optionally multiple `databricks_secret` entries from a map.

Inputs
- `name` (string) - scope name
- `initial_manage_principal` (string) - initial principal
- `secrets_map` (map(string), optional) - key->value secrets to create

Outputs
- `scope_name` - created scope name

Example
```
module "secret_scope" {
  source = "../modules/databricks_secret_scope"
  name   = "my-scope"
  secrets_map = {
    api_key = "supersecret"
  }
}
```
