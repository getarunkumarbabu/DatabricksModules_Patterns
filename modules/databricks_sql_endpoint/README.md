# Databricks SQL Endpoint (Warehouse) Module

This module manages Databricks SQL warehouses using the `databricks_sql_endpoint` resource.

## Inputs

- `name` (string) - Name of the SQL warehouse
- `cluster_size` (string) - Size of the clusters
- `min_num_clusters` (number, optional) - Minimum clusters
- `max_num_clusters` (number, optional) - Maximum clusters
- `auto_stop_mins` (number, optional) - Auto-stop duration
- `enable_photon` (bool, optional) - Enable Photon
- `warehouse_type` (string, optional) - Warehouse type
- `spot_instance_policy` (string, optional) - Spot policy
- `channel` (string, optional) - Release channel

## Outputs

- `sql_endpoint_id` - ID of the warehouse
- `sql_endpoint_name` - Name of the warehouse
- `jdbc_url` - JDBC URL for connections

## Example

```hcl
module "sql_warehouse" {
  source = "../modules/databricks_sql_endpoint"
  
  name         = "analytics-warehouse"
  cluster_size = "2X-Small"
  
  min_num_clusters = 1
  max_num_clusters = 3
  auto_stop_mins   = 30
  
  enable_photon        = true
  warehouse_type       = "PRO"
  spot_instance_policy = "COST_OPTIMIZED"
}
```

## Notes

- Warehouse types:
  - PRO: Advanced features, better performance
  - CLASSIC: Standard features
- Cluster sizes:
  - 2X-Small to 4X-Large
- Auto-stopping helps control costs
- Photon acceleration recommended for most use cases
- Consider spot instances for cost optimization