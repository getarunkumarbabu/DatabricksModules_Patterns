# Databricks Terraform Modules

This repository contains a collection of Terraform modules for managing Databricks resources. These modules provide a standardized way to create and manage various Databricks resources using Infrastructure as Code.

## Available Modules

### Workspace and Access
- [databricks_workspace_conf](./modules/databricks_workspace_conf) - Manage workspace configurations
- [databricks_directory](./modules/databricks_directory) - Manage workspace directories
- [databricks_repo](./modules/databricks_repo) - Manage Git repositories
- [databricks_token](./modules/databricks_token) - Manage access tokens

### Compute and Runtime
- [databricks_cluster](./modules/databricks_cluster) - Manage compute clusters
- [databricks_cluster_policy](./modules/databricks_cluster_policy) - Manage cluster policies
- [databricks_library](./modules/databricks_library) - Manage cluster libraries
- [databricks_global_init_script](./modules/databricks_global_init_script) - Manage global init scripts
- [databricks_instance_pool](./modules/databricks_instance_pool) - Manage instance pools

### Pipeline and Workflow
- [databricks_pipeline](./modules/databricks_pipeline) - Manage Delta Live Tables pipelines
- [databricks_job](./modules/databricks_job) - Manage automated jobs
- [databricks_sql_endpoint](./modules/databricks_sql_endpoint) - Manage SQL warehouses
- [databricks_sql_query](./modules/databricks_sql_query) - Manage SQL queries

### Security and Users
- [databricks_service_principal](./modules/databricks_service_principal) - Manage service principals
- [databricks_user](./modules/databricks_user) - Manage users
- [databricks_group](./modules/databricks_group) - Manage groups
- [databricks_permissions](./modules/databricks_permissions) - Manage resource permissions
- [databricks_ip_access_list](./modules/databricks_ip_access_list) - Manage IP access lists

### MLflow and Models
- [databricks_mlflow_model](./modules/databricks_mlflow_model) - Manage MLflow models
- [databricks_mlflow_experiment](./modules/databricks_mlflow_experiment) - Manage MLflow experiments
- [databricks_model_serving](./modules/databricks_model_serving) - Manage model serving endpoints

### Unity Catalog
- [databricks_catalog](./modules/databricks_catalog) - Manage Unity Catalog catalogs
- [databricks_schema](./modules/databricks_schema) - Manage Unity Catalog schemas
- [databricks_metastore](./modules/databricks_metastore) - Manage Unity Catalog metastores
- [databricks_external_location](./modules/databricks_external_location) - Manage external locations

## Requirements

- Terraform >= 0.13
- Databricks Provider >= 1.0.0

## Usage

Each module can be used independently. Here's a basic example that combines multiple modules:

```hcl
# Configure a cluster with a policy
module "cluster_policy" {
  source = "./modules/databricks_cluster_policy"

  name = "prod_policy"
  definition = jsonencode({
    "dbus_per_hour": {
      "type": "range",
      "maxValue": 10
    }
  })
}

module "cluster" {
  source = "./modules/databricks_cluster"

  cluster_name  = "my_cluster"
  policy_id     = module.cluster_policy.policy_id
  spark_version = "11.3.x-scala2.12"
  node_type_id  = "i3.xlarge"
  
  autoscale {
    min_workers = 1
    max_workers = 10
  }
}

# Set up Unity Catalog resources
module "catalog" {
  source = "./modules/databricks_catalog"

  name    = "prod_catalog"
  comment = "Production data catalog"
}

module "schema" {
  source = "./modules/databricks_schema"

  catalog_name = module.catalog.catalog_id
  name         = "prod_schema"
  comment      = "Production schema"
}

# Configure ML resources
module "mlflow_experiment" {
  source = "./modules/databricks_mlflow_experiment"

  name = "/prod/experiment1"
}

module "model_serving" {
  source = "./modules/databricks_model_serving"

  name          = "prod_endpoint"
  model_name    = "my_model"
  model_version = "1"
}
```

## Documentation

Each module has its own README with:
- Detailed usage instructions
- Input variables
- Output values
- Example configurations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
