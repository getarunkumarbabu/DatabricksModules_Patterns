# Databricks Global Init Script Module

This module manages global init scripts using the `databricks_global_init_script` resource.

## Inputs

- `name` (string) - Name of the init script
- `content` (string) - Content of the init script
- `enabled` (bool, optional) - Whether the script is enabled
- `position` (number, optional) - Position for execution order

## Outputs

- `script_id` - ID of the created script
- `script_name` - Name of the script

## Example

```hcl
module "init_script" {
  source = "../modules/databricks_global_init_script"
  
  name    = "install-packages"
  content = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y jq
  EOT
  enabled = true
}
```

## Notes

- Global init scripts run on all clusters in the workspace
- Scripts run as root when cluster nodes start
- Use for workspace-wide customizations like:
  - Installing system packages
  - Configuring security settings
  - Setting up logging
  - Mounting storage
- Position determines execution order if multiple scripts exist
- Content should be idempotent