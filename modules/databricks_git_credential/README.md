# Databricks Git Credential Module

This module manages Git credentials in Databricks, allowing you to authenticate with Git providers for repository operations.

## Usage

```hcl
module "git_credential" {
  source = "./modules/databricks_git_credential"

  git_username          = "username"
  git_provider         = "gitHub"
  personal_access_token = var.github_token
  force                = false
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
| git_username | The Git username for the credential | `string` | n/a | yes |
| git_provider | The Git provider (gitHub, gitLab, azureDevOpsServices, bitbucketCloud) | `string` | n/a | yes |
| personal_access_token | The personal access token for Git authentication | `string` | n/a | yes |
| force | Force update the credential even if it exists | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| git_credential_id | The ID of the Git credential |
| git_credential | The full Git credential resource |

## Notes

1. The personal access token must have appropriate permissions for the Git provider:
   - GitHub: repo scope
   - GitLab: api scope
   - Azure DevOps: Code (Read & Write)
   - Bitbucket: repository:write scope

2. The Git provider must be one of:
   - gitHub
   - gitLab
   - azureDevOpsServices
   - bitbucketCloud

3. Force update can be used to override existing credentials, but use with caution.