# Databricks Repository Module

This module manages Git repositories in the Databricks workspace using the `databricks_repo` resource.

## Inputs

- `url` (string) - Git URL of the repository to clone
- `path` (string) - Path where the repository will be mounted
- `branch` (string, optional) - Branch to checkout (conflicts with tag)
- `tag` (string, optional) - Tag to checkout (conflicts with branch)

## Outputs

- `repo_path` - Path where the repository is mounted
- `repo_id` - ID of the repository
- `head_commit_id` - HEAD commit ID

## Example

```hcl
module "repo" {
  source = "../modules/databricks_repo"
  
  url    = "https://github.com/databricks/examples.git"
  path   = "/Repos/MyProject/examples"
  branch = "main"
}
```

## Notes

- The repository will be mounted under `/Repos` in the workspace
- Either branch or tag can be specified, but not both
- Supports both HTTPS and SSH Git URLs
- Personal access tokens or SSH keys should be configured separately