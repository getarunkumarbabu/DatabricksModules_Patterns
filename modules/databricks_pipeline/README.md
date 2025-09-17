# Databricks Pipeline Module

This module manages Delta Live Tables pipelines using the `databricks_pipeline` resource.

## Inputs

- `name` (string) - Pipeline name
- `storage` (string) - Storage location
- `target` (string) - Target table
- `channel` (string, optional) - Release channel
- `edition` (string, optional) - Pipeline edition
- `photon` (bool, optional) - Enable Photon
- `cluster_config` (object, optional) - Cluster configuration:
  - label
  - num_workers
  - driver_node_type_id
  - node_type_id
  - custom_tags
- `libraries` (list, optional) - Libraries to install
- `notifications` (object, optional) - Notification settings:
  - email_recipients
  - on_failure
  - on_success

## Outputs

- `pipeline_id` - ID of created pipeline
- `pipeline_name` - Name of pipeline

## Example

```hcl
module "dlt_pipeline" {
  source = "../modules/databricks_pipeline"
  
  name    = "my-pipeline"
  storage = "/pipelines/my-pipeline"
  target  = "my_catalog.my_schema"
  
  cluster_config = {
    label               = "default"
    num_workers         = 2
    driver_node_type_id = "Standard_DS3_v2"
    node_type_id        = "Standard_DS3_v2"
  }
  
  libraries = [{
    maven_coordinates = "com.databricks:spark-xml_2.12:0.14.0"
  }]
  
  notifications = {
    email_recipients = ["team@example.com"]
    on_failure      = true
    on_success      = false
  }
}
```

## Notes

- Delta Live Tables is an advanced feature requiring appropriate licensing
- Storage path should be unique per pipeline
- Consider using catalog/schema for target organization
- Cluster autoscaling is handled automatically by DLT service