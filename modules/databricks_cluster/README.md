# Azure Databricks Cluster Module

This module manages Azure Databricks compute clusters with support for various Azure VM types and configurations. It provides a flexible interface for creating and managing clusters optimized for various workloads like ETL, ML training, and interactive analytics.

## Features

- Support for Azure VM types and instance pools
- Fixed-size and autoscaling cluster configurations
- Azure Spot instance support for cost optimization
- Integration with Azure security features
- Custom initialization scripts
- Library management and dependencies
- Workload-specific optimizations

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |

## Usage Examples

### Basic Development Cluster

```hcl
module "dev_cluster" {
  source = "./modules/databricks_cluster"

  cluster_name  = "dev-cluster"
  spark_version = "13.3.x-scala2.12"
  node_type_id  = "Standard_DS3_v2"
  
  autoscale_config = {
    min_workers = 1
    max_workers = 3
  }
  
  autotermination_minutes = 30
}
```

### Production ML Cluster

```hcl
module "ml_cluster" {
  source = "./modules/databricks_cluster"

  cluster_name         = "ml-training-cluster"
  spark_version       = "13.3.x-gpu-ml-scala2.12"  # GPU-enabled ML runtime
  node_type_id       = "Standard_NC6s_v3"         # Azure GPU VM
  driver_node_type_id = "Standard_DS4_v2"         # Larger driver for ML tasks
  
  autoscale_config = {
    min_workers = 2
    max_workers = 8
  }

  spark_conf = {
    "spark.databricks.delta.preview.enabled" = "true"
    "spark.databricks.io.cache.enabled"      = "true"
    "spark.rapids.sql.enabled"               = "true"  # GPU acceleration
  }

  libraries = [
    {
      pypi = "scikit-learn==1.3.0"
    },
    {
      pypi = "torch==2.0.1"  # PyTorch for GPU
    }
  ]

  custom_tags = {
    environment = "production"
    department  = "data_science"
    cost_center = "ml_001"
  }
}
```

### High-Performance ETL Cluster with Azure Spot Instances

```hcl
module "etl_cluster" {
  source = "./modules/databricks_cluster"

  cluster_name  = "etl-processing"
  spark_version = "13.3.x-photon-scala2.12"
  node_type_id  = "Standard_E8s_v5"
  
  autoscale_config = {
    min_workers = 2
    max_workers = 10
  }
  
  azure_attributes = {
    availability = "SPOT_AZURE"
    first_on_demand = 1
    spot_bid_max_price = -1  # -1 means maximum price for Spot VMs
  }

  spark_conf = {
    "spark.databricks.delta.optimizeWrite.enabled" = "true"
    "spark.databricks.io.cache.enabled" = "true"
    "spark.databricks.adaptive.autoOptimizeShuffle.enabled" = "true"
  }

  workload_config = {
    workload_type = "ETL"
    configuration = {
      "spark.databricks.cluster.profile" = "IO_INTENSIVE"
    }
  }

  init_scripts = [{
    destination = "dbfs:/databricks/scripts/init/optimize-etl.sh"
  }]

  cluster_log_conf = {
    destination = "dbfs:/cluster-logs/etl/"
  }

  custom_tags = {
    environment = "production"
    workload    = "etl"
    cost_center = "data_eng"
  }
}
```
```

## Common Cluster Configurations

### Development and Testing
- Small clusters with Standard_DS3_v2 instances
- Autoscaling from 1-3 workers
- 30-minute autotermination
- Standard DBR versions

### Machine Learning
- GPU-enabled instances (Standard_NC-series)
- ML-optimized runtimes with GPU support
- Larger driver nodes (Standard_DS4_v2)
- Common ML libraries pre-installed

### ETL/Data Processing
- Cost-optimized with Azure Spot instances
- Memory-optimized instances (Standard_E-series)
- Photon-enabled runtimes
- I/O and shuffle optimizations

### Interactive Analytics
- Memory-optimized instances
- Moderate autoscaling
- Enhanced caching configurations
- Interactive runtime versions
- Fixed-size clusters
- Memory-optimized instances
- Fast startup configurations
- Interactive-optimized settings

## Input Details

### Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Unique cluster name within workspace | `string` | n/a | yes |
| spark_version | Runtime version (e.g., "13.3.x-scala2.12") | `string` | n/a | yes |
| node_type_id | Worker node type ID | `string` | n/a | yes |

### Optional Core Settings

| Name | Description | Type | Default |
|------|-------------|------|---------|
| driver_node_type_id | Driver node type ID | `string` | `null` |
| instance_pool_id | Instance pool ID | `string` | `null` |
| policy_id | Cluster policy ID | `string` | `null` |
| num_workers | Fixed cluster size | `number` | `null` |
| autoscale_config | Min/max workers config | `object` | `null` |
| autotermination_minutes | Idle termination time | `number` | `60` |

### Advanced Features

| Name | Description | Type | Default |
|------|-------------|------|---------|
| enable_elastic_disk | Dynamic storage scaling | `bool` | `true` |
| enable_local_disk_encryption | Data encryption | `bool` | `false` |
| workload_config | Workload optimizations | `object` | `null` |
| init_scripts | Startup scripts | `list` | `null` |
| libraries | Package dependencies | `list` | `null` |

### Cloud Provider Settings

| Name | Description | Type | Default |
|------|-------------|------|---------|
| azure_attributes | Azure configurations | `object` | `null` |

## Output Details

### Core Information

| Name | Description |
|------|-------------|
| cluster_id | Unique cluster identifier |
| cluster_name | Display name |
| state | Current cluster state |
| state_message | Status details |

### Configuration Details

| Name | Description |
|------|-------------|
| cluster_configuration | Full config snapshot |
| cloud_attributes | Provider settings |
| cluster_size | Worker count details |

### Resource Information

| Name | Description |
|------|-------------|
| cluster_cores | Total CPU cores |
| cluster_memory_mb | Total memory (MB) |
| default_tags | System-added tags |

## Best Practices

### Cost Optimization
1. Use spot instances for non-critical workloads
2. Enable autoscaling with appropriate limits
3. Set reasonable autotermination times
4. Consider instance pools for faster startup

### Performance Tuning
1. Match node types to workload requirements
2. Configure Spark properly for the use case
3. Use cluster-optimized runtime versions
4. Enable performance features when appropriate

### Security
1. Enable disk encryption for sensitive data
2. Use cluster policies to enforce standards
3. Implement proper access controls
4. Monitor cluster activities via logs

### Monitoring
1. Configure cluster logging
2. Set up alerts for failures
3. Track resource utilization
4. Monitor job performance

## Troubleshooting

### Common Issues

1. Cluster Startup Failures
   - Check node type availability
   - Verify runtime version compatibility
   - Review init script logs
   - Check network connectivity

2. Performance Problems
   - Monitor resource utilization
   - Review Spark configurations
   - Check for memory pressure
   - Analyze job metrics

3. Library Issues
   - Verify library compatibility
   - Check installation logs
   - Confirm dependency versions
   - Test in isolation

### Support Resources

For assistance:
1. Check Databricks documentation
2. Review cluster event logs
3. Monitor driver/worker logs
4. Contact Databricks support
