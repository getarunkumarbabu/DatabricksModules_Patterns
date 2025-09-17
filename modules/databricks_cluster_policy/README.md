# Databricks Cluster Policy Module

This advanced module manages Databricks cluster policies, enabling organizations to enforce standardized configurations, control costs, and maintain security across all cluster deployments. It supports policy families, comprehensive library management, and detailed policy definitions for all cluster aspects.

## Features

- Policy inheritance through policy families
- Granular cluster configuration control
- Built-in validation and security checks
- Multi-cloud support (AWS, Azure, GCP)
- Automated library management
- Cost control mechanisms

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.3.0 |

## Usage Examples

### Basic Development Policy

```hcl
module "dev_policy" {
  source = "./modules/databricks_cluster_policy"

  name        = "development-standard"
  description = "Standard policy for development clusters"

  definition = jsonencode({
    "spark_version": {
      "type": "regex",
      "pattern": "^[0-9]+\\.[0-9]+\\.x-scala2\\.12$"
    },
    "node_type_id": {
      "type": "allowlist",
      "values": [
        "Standard_DS3_v2",
        "Standard_DS4_v2"
      ]
    },
    "autotermination_minutes": {
      "type": "fixed",
      "value": 120
    },
    "custom_tags.team": {
      "type": "fixed",
      "value": "development"
    }
  })

  max_clusters_per_user = 2
}
```

### Production ML Policy

```hcl
module "ml_policy" {
  source = "./modules/databricks_cluster_policy"

  name        = "ml-training-policy"
  description = "Policy for production ML training clusters"

  definition = jsonencode({
    "spark_version": {
      "type": "allowlist",
      "values": [
        "13.3.x-cpu-ml-scala2.12",
        "13.3.x-gpu-ml-scala2.12"
      ]
    },
    "node_type_id": {
      "type": "allowlist",
      "values": [
        "Standard_NC6s_v3",
        "Standard_NC12s_v3"
      ]
    },
    "spark_conf.spark.databricks.cluster.profile": {
      "type": "fixed",
      "value": "ML"
    },
    "custom_tags": {
      "type": "fixed",
      "value": {
        "environment": "production",
        "workload": "ml-training"
      }
    }
  })

  libraries = {
    pypi = [
      "scikit-learn==1.3.0",
      "torch==2.0.1",
      "transformers>=4.30.0"
    ],
    whl = ["dbfs:/libraries/custom_ml_utils-1.0.0-py3-none-any.whl"]
  }

  max_clusters_per_user = 3
}
```

### Enterprise Cost Control Policy

```hcl
module "enterprise_policy" {
  source = "./modules/databricks_cluster_policy"

  name        = "enterprise-standard"
  description = "Enterprise-wide cost control and security policy"
  
  policy_family_id = "default"
  policy_family_overrides = {
    "spark_conf.spark.databricks.cluster.profile": {
      "type": "allowlist",
      "values": ["ETL", "ANALYTICS"]
    }
  }

  definition = jsonencode({
    "node_type_id": {
      "type": "allowlist",
      "values": ["Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2"]
    },
    "autotermination_minutes": {
      "type": "range",
      "minValue": 10,
      "maxValue": 120
    },
    "enable_elastic_disk": {
      "type": "fixed",
      "value": true
    },
    "azure_attributes": {
      "type": "fixed",
      "value": {
        "availability": "ON_DEMAND_AZURE",
        "first_on_demand": 1
      }
    },
    "custom_tags.costCenter": {
      "type": "required"
    },
    "custom_tags.environment": {
      "type": "allowlist",
      "values": ["dev", "staging", "prod"]
    }
  })

  max_clusters_per_user = 5
}
```

### Data Engineering Policy with Instance Pools

```hcl
module "etl_policy" {
  source = "./modules/databricks_cluster_policy"

  name        = "etl-standard"
  description = "Standard policy for ETL workloads"

  definition = jsonencode({
    "instance_pool_id": {
      "type": "allowlist",
      "values": ["pool-123", "pool-456"]
    },
    "spark_version": {
      "type": "allowlist",
      "values": ["13.3.x-photon-scala2.12"]
    },
    "spark_conf": {
      "type": "fixed",
      "value": {
        "spark.databricks.photon.enabled": "true",
        "spark.databricks.adaptive.autoOptimizeShuffle.enabled": "true",
        "spark.databricks.adaptive.autoOptimizeShuffle.shuffleTargetSize": "64m"
      }
    },
    "autoscale": {
      "type": "fixed",
      "value": {
        "min_workers": 2,
        "max_workers": 10
      }
    }
  })

  libraries = {
    maven = [{
      coordinates = "org.apache.spark:spark-sql-kafka-0-10_2.12:3.4.0"
    }],
    jar = ["dbfs:/libraries/etl-utils.jar"]
  }
}
```

## Policy Types and Use Cases

### Development Policies
- Limit resource usage
- Enforce auto-termination
- Allow development runtime versions
- Enable basic monitoring

### Production Policies
- Strict version control
- Resource guarantees
- Enhanced security
- Required monitoring
- Cost optimization

### ML-Specific Policies
- GPU instance access
- ML runtime requirements
- Framework versioning
- Storage configurations

### ETL Policies
- Performance optimization
- Auto-scaling rules
- Storage management
- Cost controls

## Policy Components

### Node Types and Sizing
```hcl
"node_type_id": {
  "type": "allowlist",
  "values": ["Standard_DS3_v2", "Standard_DS4_v2"]
}
```

### Runtime Versions
```hcl
"spark_version": {
  "type": "regex",
  "pattern": "^[0-9]+\\.[0-9]+\\.x-scala2\\.12$"
}
```

### Auto-termination
```hcl
"autotermination_minutes": {
  "type": "range",
  "minValue": 10,
  "maxValue": 180
}
```

### Tags and Labels
```hcl
"custom_tags": {
  "type": "fixed",
  "value": {
    "environment": "production",
    "managed_by": "terraform"
  }
}
```

## Best Practices

### Policy Design
1. Start with policy families
2. Layer restrictions appropriately
3. Document extensively
4. Consider upgrade paths
5. Plan for exceptions

### Cost Control
1. Set auto-termination limits
2. Control instance types
3. Implement spot usage
4. Monitor utilization
5. Use cluster pools

### Security
1. Enforce encryption
2. Control network access
3. Manage library sources
4. Audit configurations
5. Implement least privilege

### Maintenance
1. Regular policy reviews
2. Version tracking
3. Usage monitoring
4. Update documentation
5. Performance analysis

## Troubleshooting

### Common Issues

1. Policy Conflicts
   - Check policy family inheritance
   - Review override precedence
   - Validate definitions

2. Library Problems
   - Verify compatibility
   - Check access permissions
   - Validate versions

3. Cost Management
   - Monitor cluster usage
   - Review termination settings
   - Analyze spot usage

### Support Process

1. Check Documentation
   - Review policy definitions
   - Verify configurations
   - Check error messages

2. Gather Information
   - Policy configuration
   - Cluster creation logs
   - Error details

3. Common Solutions
   - Update policy definitions
   - Check permissions
   - Verify resource availability

## Migration Guide

### From Legacy Policies

1. Document current state
2. Identify requirements
3. Design new policies
4. Test thoroughly
5. Migrate gradually

### Between Clouds

1. Update instance types
2. Adjust configurations
3. Verify libraries
4. Test deployments
5. Monitor performance

## Advanced Topics

### Policy Families
- Inheritance patterns
- Override strategies
- Version management
- Migration planning

### Cost Optimization
- Spot instance usage
- Pool integration
- Auto-scaling rules
- Budget enforcement

### Security Controls
- Network isolation
- Data encryption
- Access patterns
- Audit requirements

### Performance Tuning
- Resource allocation
- Runtime selection
- Library management
- Monitoring setup
| definition | Policy definition as JSON string or map. Controls cluster configurations and restrictions. | `any` | - | yes |
| max_clusters_per_user | Maximum number of clusters per user under this policy | `number` | `null` | no |
| policy_family_id | ID of a policy family to extend | `string` | `null` | no |
| policy_family_overrides | Map of overrides when extending a policy family | `map(any)` | `{}` | no |
| libraries | Libraries to be installed on all clusters using this policy | <pre>object({
  jar  = optional(list(string))
  egg  = optional(list(string))
  whl  = optional(list(string))
  pypi = optional(list(string))
  maven = optional(list(object({
    coordinates = string
    repo        = optional(string)
    exclusions  = optional(list(string))
  })))
  cran = optional(list(string))
})</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| policy_id | ID of the created cluster policy |
| policy_name | Name of the created policy |
| policy_definition | The final policy definition after applying any family overrides |
| policy_family | Information about the policy family if one was used |
| max_clusters_per_user | Maximum number of clusters per user allowed by this policy |
| libraries | Libraries configured for this policy |

## Policy Definition Examples

### Basic Development Policy

```hcl
module "dev_policy" {
  source = "../modules/databricks_cluster_policy"
  
  name        = "dev-policy"
  description = "Development environment policy"

  definition = jsonencode({
    "spark_version": {
      "type": "regex",
      "pattern": "11\\.[0-9]+\\.x-scala.*"
    },
    "node_type_id": {
      "type": "allowlist",
      "values": ["Standard_DS3_v2"]
    },
    "autotermination_minutes": {
      "type": "fixed",
      "value": 60
    },
    "num_workers": {
      "type": "range",
      "minValue": 1,
      "maxValue": 4
    }
  })
}
```

### Production Policy with Libraries

```hcl
module "prod_policy" {
  source = "../modules/databricks_cluster_policy"
  
  name        = "prod-policy"
  description = "Production environment policy"

  definition = jsonencode({
    "spark_version": {
      "type": "fixed",
      "value": "11.3.x-scala2.12"
    },
    "node_type_id": {
      "type": "fixed",
      "value": "Standard_DS4_v2"
    },
    "custom_tags.environment": {
      "type": "fixed",
      "value": "production"
    }
  })

  libraries = {
    pypi = [
      "scikit-learn==1.0.2",
      "pandas==1.4.2"
    ],
    maven = [{
      coordinates = "com.databricks:spark-xml_2.12:0.14.0"
    }]
  }

  max_clusters_per_user = 2
}
```

### Policy Using Family

```hcl
module "extended_policy" {
  source = "../modules/databricks_cluster_policy"
  
  name             = "extended-policy"
  policy_family_id = "fair-use"
  
  policy_family_overrides = {
    "spark_version" = {
      "type": "fixed",
      "value": "11.3.x-scala2.12"
    }
  }
}
```

## Common Policy Controls

You can control various aspects of cluster configuration through the policy definition:

1. Compute Resources
   - Node types (instance types)
   - Minimum/maximum workers
   - Autoscaling limits
   - GPU enablement

2. Runtime Settings
   - Spark versions
   - Python/R versions
   - Runtime engine (Photon)

3. Cost Control
   - DBU limits
   - Autotermination settings
   - Maximum clusters per user
   - Instance pools usage

4. Security & Compliance
   - Network isolation
   - Encryption settings
   - Access controls
   - Required tags

5. Libraries & Dependencies
   - Pre-installed libraries
   - Package versions
   - Custom JAR/wheel files

## Best Practices

1. Use policy families for common base policies
2. Implement strict controls in production
3. Set reasonable auto-termination limits
4. Enforce tagging standards
5. Pin critical library versions
6. Use allowlists for approved node types
7. Set appropriate cluster size limits
8. Document policy decisions in descriptions