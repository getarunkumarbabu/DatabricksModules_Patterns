# Databricks Global Init Script Module

This module manages global init scripts using the `databricks_global_init_script` resource. Global init scripts are shell scripts that run on all clusters in a workspace during cluster startup.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.0.0 |

## Usage

### Basic Example with Inline Script

```hcl
module "basic_init_script" {
  source = "../modules/databricks_global_init_script"
  
  name    = "install-packages"
  content = <<-EOT
    #!/bin/bash
    set -e
    apt-get update
    apt-get install -y jq curl
  EOT
  enabled  = true
  position = 10
}
```

### Using Local Script File

```hcl
module "file_init_script" {
  source = "../modules/databricks_global_init_script"
  
  name        = "setup-environment"
  source_path = "${path.module}/scripts/setup.sh"
  position    = 20
}
```

### Using Existing DBFS Script

```hcl
module "dbfs_init_script" {
  source = "../modules/databricks_global_init_script"
  
  name   = "configure-storage"
  source = "dbfs:/init-scripts/storage-setup.sh"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the init script | `string` | - | yes |
| content | Content of the init script. Required if source and source_path are not provided | `string` | `null` | no |
| source | Source path in DBFS for an existing init script | `string` | `null` | no |
| source_path | Local path to the init script file to be uploaded | `string` | `null` | no |
| enabled | Whether the init script is enabled | `bool` | `true` | no |
| position | Position of the init script (determines execution order). Lower numbers run first | `number` | `null` | no |

**Note:** Exactly one of `content`, `source`, or `source_path` must be provided.

## Outputs

| Name | Description |
|------|-------------|
| script_id | ID of the created init script |
| script_name | Name of the init script |
| enabled | Whether the init script is enabled |
| position | The execution position of the init script |
| created_at | Timestamp when the init script was created |
| updated_at | Timestamp when the init script was last updated |
| source_path | DBFS source path of the init script if provided |

## Global Init Script Best Practices

1. **Script Structure**
   ```bash
   #!/bin/bash
   set -e  # Exit on error
   set -x  # Print commands for debugging

   # Log script start
   echo "Starting init script: $(basename "$0")"

   # Your script content here

   # Log completion
   echo "Init script completed successfully"
   ```

2. **Error Handling**
   - Use `set -e` to exit on errors
   - Add error handling for critical operations
   - Log errors to help with debugging

3. **Idempotency**
   - Scripts should be idempotent (safe to run multiple times)
   - Check if actions are needed before executing
   - Use guard clauses for installations

4. **Performance**
   - Keep scripts lightweight
   - Avoid unnecessary downloads/installations
   - Cache downloads when possible

5. **Security**
   - Avoid hardcoding sensitive information
   - Use proper file permissions
   - Validate downloads using checksums

6. **Position and Ordering**
   - Use position to control execution order
   - Lower numbers run first
   - Leave gaps (10, 20, 30...) for future scripts

## Common Use Cases

1. **System Package Installation**
   ```bash
   #!/bin/bash
   set -e

   # Check if packages are already installed
   if ! dpkg -l | grep -q "jq"; then
     apt-get update
     apt-get install -y jq
   fi
   ```

2. **Environment Configuration**
   ```bash
   #!/bin/bash
   set -e

   # Set environment variables
   cat << EOF >> /etc/environment
   JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
   HADOOP_CONF_DIR=/etc/hadoop/conf
   EOF
   ```

3. **Storage Mounting**
   ```bash
   #!/bin/bash
   set -e

   # Mount storage if not already mounted
   if ! mountpoint -q /mnt/data; then
     mount -t nfs storage:/data /mnt/data
   fi
   ```

## Limitations and Considerations

1. Scripts run as root on all cluster nodes
2. Scripts must complete within 10 minutes
3. Failed scripts may prevent cluster startup
4. Scripts run on both driver and worker nodes
5. Environment variables from cluster configs are available
6. Scripts run at cluster start/restart only
7. Cannot access Databricks workspace APIs

## Troubleshooting

1. Check cluster event logs for script execution errors
2. Verify script permissions (should be executable)
3. Ensure script is idempotent
4. Check script execution time stays under limits
5. Validate DBFS paths if using source option
6. Monitor cluster startup times for performance impact