# Databricks Instance Pool Module

Creates a `databricks_instance_pool` resource for reuse across clusters/jobs.

Inputs
- `name` (string)
- `min_idle_instances` (number)
- `max_capacity` (number)
- `node_type_id` (string)
- `idle_instance_autotermination_minutes` (number)
- `aws_availability` (string)

Outputs
- `instance_pool_id`

Example
```
module "instance_pool" {
  source = "../modules/databricks_instance_pool"
  name   = "my-pool"
  max_capacity = 10
  node_type_id = "Standard_DS3_v2"
}
```
