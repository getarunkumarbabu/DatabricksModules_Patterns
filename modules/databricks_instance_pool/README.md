# Databricks Instance Pool Module

This module manages Databricks instance pools, which allow you to reduce cluster start and scale-up times by maintaining a set of idle, ready-to-use instances.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.0.0 |

## Usage

### Basic AWS Example

```hcl
module "aws_instance_pool" {
  source = "../modules/databricks_instance_pool"
  
  name                = "aws-analytics-pool"
  max_capacity       = 20
  min_idle_instances = 2
  node_type_id       = "m5.2xlarge"
  
  idle_instance_autotermination_minutes = 30
  enable_elastic_disk = true
  
  aws_attributes = {
    availability            = "SPOT"
    zone_id                = "us-west-2a"
    spot_bid_price_percent = 100
  }
  
  disk_spec = {
    disk_type = {
      ebs_volume_type = "GENERAL_PURPOSE_SSD"
    }
    disk_count = 1
    disk_size  = 100
  }
  
  custom_tags = {
    Environment = "Production"
    Team        = "Analytics"
  }
}
```

### Azure Example with Spot Instances

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
| node_type_id | Node type ID for instances (e.g., Standard_DS3_v2 for Azure, m5.large for AWS) | `string` | - | yes |
| idle_instance_autotermination_minutes | Minutes after which idle instances are terminated | `number` | `60` | no |
| enable_elastic_disk | Enable elastic disk optimization | `bool` | `true` | no |
| preloaded_spark_versions | List of Spark versions to preload | `list(string)` | `null` | no |
| custom_tags | Custom tags for instances | `map(string)` | `null` | no |
| aws_attributes | AWS-specific attributes | See below | `null` | no |
| azure_attributes | Azure-specific attributes | See below | `null` | no |
| disk_spec | Disk specification | See below | `null` | no |
| preloaded_docker_images | Docker images to preload | See below | `null` | no |

### AWS Attributes

```hcl
object({
  availability            = string  # SPOT or ON_DEMAND
  zone_id                = optional(string)
  spot_bid_price_percent = optional(number)
})
```

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
    ebs_volume_type = optional(string)  # GENERAL_PURPOSE_SSD or THROUGHPUT_OPTIMIZED_HDD
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
| aws_attributes | AWS-specific configuration |
| azure_attributes | Azure-specific configuration |
| disk_spec | Disk configuration |
| preloaded_docker_images | Configured docker images |
| pool_info | Combined pool information including usage stats |

## Best Practices

1. **Instance Pool Sizing**
   - Set `min_idle_instances` based on expected baseline usage
   - Set `max_capacity` considering cost and peak demand
   - Use auto-termination to manage costs

2. **Cost Optimization**
   - Use spot instances where possible
   - Set appropriate bid prices/percentages
   - Configure auto-termination for idle instances
   - Enable elastic disk when variable storage is needed

3. **Performance**
   - Preload commonly used Spark versions
   - Use instance types appropriate for workload
   - Configure sufficient disk space
   - Consider local SSDs for I/O-intensive workloads

4. **Availability**
   - Use ON_DEMAND for critical workloads
   - Consider multiple pools across zones
   - Set appropriate spot bid limits

5. **Management**
   - Use meaningful names and tags
   - Document pool purposes
   - Monitor usage statistics
   - Regularly review and adjust settings

## Notes and Limitations

1. Instance pools are workspace-specific
2. Changes to pool settings may require recreation
3. Some features are cloud-provider specific
4. Spot instance availability varies by region/zone
5. Docker image preloading may increase startup time

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
