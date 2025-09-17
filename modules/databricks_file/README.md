# Databricks File Module

This module manages individual files in the Databricks workspace, allowing you to upload and manage files directly.

## Usage

```hcl
# Upload a file from local path
module "script_file" {
  source = "./modules/databricks_file"

  path        = "/Shared/scripts/process.py"
  source_path = "./scripts/process.py"
}

# Upload a file with base64 content
module "config_file" {
  source = "./modules/databricks_file"

  path           = "/Shared/configs/app.conf"
  content_base64 = base64encode("key=value")
  md5            = md5(base64encode("key=value"))
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
| path | Workspace path for file | string | n/a | yes |
| source_path | Local source file path | string | null | no |
| content_base64 | Base64-encoded content | string | null | no |
| md5 | MD5 hash of content | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| file_path | Path in workspace |
| size | File size in bytes |
| object_id | File object ID |

## Notes

- Use either source_path or content_base64
- MD5 hash helps with change detection
- Consider workspace path organization
- Be cautious with large files
- File permissions follow workspace rules
- Use for scripts, configs, etc.
- Not recommended for binary files