# Databricks Instance Pool Module

This module manages Databricks instance pools, which allow you to reduce cluster start and scale-up times by maintaining a set of idle, ready-to-use instances.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.0.0 |

## Usage

### Basic Example with Spot Instances

```hcl
module "azure_instance_pool" {
  source = "../modules/databricks_instance_pool"
  
  name                = "azure-ml-pool"
  max_capacity       = 10
  min_idle_instances = 1
  node_type_id       = "Standard_DS4_v2"
  
  azure_attributes = {
    availability        = "SPOT_AZURE"
    spot_bid_max_price = 0.5
  }
  
  preloaded_spark_versions = [
    "11.3.x-cpu-ml-scala2.12",
    "11.3.x-gpu-ml-scala2.12"
  ]
  
  preloaded_docker_images = [{
    url = "databricks/gpu-image:latest"
    basic_auth = {
      username = "username"
      password = "password"
    }
  }]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Instance pool name | `string` | - | yes |
| min_idle_instances | Minimum number of idle instances to maintain | `number` | `0` | no |
| max_capacity | Maximum number of instances the pool can contain | `number` | - | yes |
| node_type_id | Node type ID for instances (e.g., Standard_DS3_v2, Standard_F4s_v2) | `string` | - | yes |
| idle_instance_autotermination_minutes | Minutes after which idle instances are terminated | `number` | `60` | no |
| enable_elastic_disk | Enable elastic disk optimization | `bool` | `true` | no |
| preloaded_spark_versions | List of Spark versions to preload | `list(string)` | `null` | no |
| custom_tags | Custom tags for instances | `map(string)` | `null` | no |
| azure_attributes | Azure-specific attributes | See below | `null` | no |
| disk_spec | Disk specification | See below | `null` | no |
| preloaded_docker_images | Docker images to preload | See below | `null` | no |

### Azure Attributes

```hcl
object({
  availability        = string  # SPOT_AZURE or ON_DEMAND_AZURE
  spot_bid_max_price = optional(number)
})
```

### Disk Specification

```hcl
object({
  disk_type = object({
    azure_disk_volume_type = optional(string)  # STANDARD_LRS or PREMIUM_LRS
  })
  disk_count = number
  disk_size  = number
})
```

### Docker Images

```hcl
list(object({
  url = string
  basic_auth = optional(object({
    username = string
    password = string
  }))
}))
```

## Outputs

| Name | Description |
|------|-------------|
| instance_pool_id | ID of the instance pool |
| instance_pool_name | Name of the instance pool |
| min_idle_instances | Minimum number of idle instances |
| max_capacity | Maximum capacity of the instance pool |
| node_type_id | Node type ID used in the instance pool |
| preloaded_spark_versions | List of preloaded Spark versions |
| state | Current state of the instance pool |
| stats | Statistics about the instance pool |
| idle_instance_autotermination_minutes | Instance idle timeout in minutes |
| enable_elastic_disk | Elastic disk optimization status |
| custom_tags | Applied custom tags |
| azure_attributes | Azure instance configuration |
| disk_spec | Disk configuration |
| preloaded_docker_images | Configured docker images |
| pool_info | Combined pool information including usage stats |

## Best Practices

1. **Instance Pool Sizing**
   - Set `min_idle_instances` based on expected baseline usage
   - Set `max_capacity` considering cost and peak demand
   - Use auto-termination to manage costs

2. **Cost Optimization**
   - Use Azure Spot instances where possible
   - Configure appropriate max spot price
   - Set auto-termination for idle instances
   - Enable elastic disk for storage flexibility

3. **Performance**
   - Preload commonly used Spark versions
   - Choose appropriate Azure VM types
   - Use Premium SSD for I/O-intensive workloads
   - Configure adequate disk space

4. **Availability**
   - Use ON_DEMAND_AZURE for critical workloads
   - Consider multiple pools across Azure zones
   - Set appropriate spot bid limits
   - Monitor spot instance evictions

5. **Management**
   - Use meaningful names and tags
   - Document pool purposes
   - Monitor usage statistics
   - Review and adjust settings regularly

## Notes and Limitations

1. Instance pools are workspace-specific
2. Changes to pool settings may require recreation
3. Consider Azure region spot instance availability
4. Azure Premium SSDs recommended for production
5. Docker image preloading affects startup time

## Troubleshooting

1. **Pool Not Scaling**
   - Check max_capacity limits
   - Verify quota availability
   - Check for spot instance availability

2. **Long Instance Start Times**
   - Review preloaded versions/images
   - Check disk configurations
   - Verify network connectivity

3. **Cost Issues**
   - Review auto-termination settings
   - Check spot bid configurations
   - Monitor idle instance counts
