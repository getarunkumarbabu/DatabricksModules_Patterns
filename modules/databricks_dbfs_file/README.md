# Databricks DBFS File Module

This module manages files in Databricks File System (DBFS).

## Features

- Upload files to DBFS from local sources
- Create files with direct content
- Support for base64-encoded content
- MD5 hash validation
- Optional file overwrite

## Usage

```hcl
module "example_file" {
  source = "./modules/databricks_dbfs_file"

  path      = "/dbfs/path/to/file.txt"
  source    = "local/path/to/file.txt"
  overwrite = true
  
  # Optional: MD5 hash for validation
  md5 = "d41d8cd98f00b204e9800998ecf8427e"
}
```

## Examples

### Upload Local File

```hcl
module "config_file" {
  source = "./modules/databricks_dbfs_file"

  path   = "/dbfs/configs/app.conf"
  source = "./configs/app.conf"
}
```

### Create File with Direct Content

```hcl
module "settings_file" {
  source = "./modules/databricks_dbfs_file"

  path    = "/dbfs/settings/config.json"
  content = jsonencode({
    environment = "production"
    debug      = false
  })
}
```

### Upload Base64 Content

```hcl
module "encoded_file" {
  source = "./modules/databricks_dbfs_file"

  path        = "/dbfs/encoded/data.bin"
  content_b64 = "SGVsbG8gV29ybGQh"
}
```

## Requirements

- Databricks provider configured with workspace access
- Appropriate permissions to manage DBFS files

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| path | The path in DBFS where the file should be stored | `string` | n/a | yes |
| source | The local path to the file to upload | `string` | `null` | no |
| content | The direct content to be stored in the file | `string` | `null` | no |
| content_b64 | The base64-encoded content to be stored in the file | `string` | `null` | no |
| overwrite | Whether to overwrite an existing file | `bool` | `false` | no |
| md5 | The MD5 hash of the file content for validation | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dbfs_path | The path where the file is stored in DBFS |
| file_size | The size of the file in bytes |
| dbfs_file_id | The unique identifier of the file in DBFS |

## Notes

1. Only one of `source`, `content`, or `content_b64` should be specified.
2. Files in DBFS are accessible to all cluster nodes.
3. Use MD5 hash validation for sensitive files.
4. Consider access controls and permissions.

## Best Practices

1. Use clear, hierarchical paths in DBFS
2. Implement version control for configuration files
3. Validate file contents after upload
4. Use appropriate file permissions
5. Consider using secret management for sensitive files