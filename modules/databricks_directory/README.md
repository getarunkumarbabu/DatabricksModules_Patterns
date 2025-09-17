# Databricks Directory Module

This module manages directories in the Databricks workspace using the `databricks_directory` resource.

## Inputs

- `path` (string) - The workspace path where the directory should be created

## Outputs

- `directory_path` - The path of the created directory
- `object_id` - The object ID of the created directory

## Example

```hcl
module "workspace_directory" {
  source = "../modules/databricks_directory"
  path   = "/Shared/MyProject"
}
```

## Notes

- The path must start with `/Shared`, `/Users`, or `/Repos`
- Parent directories will be created automatically if they don't exist
- Directories are workspace objects and can be used with permissions resources