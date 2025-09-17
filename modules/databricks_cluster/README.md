# Databricks Cluster Module

This module creates a Databricks cluster using the `databricks` provider.

Inputs
- `cluster_name` (string) - cluster name
- `spark_version` (string) - runtime version
- `node_type_id` (string) - node type id
- `autotermination_minutes` (number, default=60)
- `autoscale_min_workers` (number, default=1)
- `autoscale_max_workers` (number, default=2)
- `spark_conf` (map(string), default={})
- `enable_elastic_disk` (bool, default=false)
- `custom_tags` (map(string), optional)

Outputs
- `cluster_id` - the cluster id
- `cluster_name` - cluster name

Example
```
module "cluster" {
  source         = "../modules/databricks_cluster"
  cluster_name   = "example-cluster"
  spark_version  = "12.0.x-scala2.12"
  node_type_id   = "Standard_DS3_v2"
}
```
