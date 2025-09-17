# Databricks Job Module

Creates a `databricks_job` resource that runs a notebook on a new ephemeral cluster.

Inputs
- `name` (string) - job name
- `spark_version` (string) - runtime
- `node_type_id` (string)
- `autotermination_minutes` (number)
- `notebook_path` (string)
- `max_retries` (number)

Outputs
- `job_id` - ID of the created job

Example
```
module "job" {
  source       = "../modules/databricks_job"
  name         = "example-job"
  node_type_id = "Standard_DS3_v2"
  notebook_path = "/Users/me/MyNotebook"
}
```
