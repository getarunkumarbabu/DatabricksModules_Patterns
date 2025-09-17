# Databricks Registered Model Module

This module manages MLflow registered models in Databricks Unity Catalog.

## Usage

```hcl
module "example_model" {
  source = "./modules/databricks_registered_model"

  model_name       = "fraud_detection_model"
  description      = "Model for detecting fraudulent transactions"
  catalog_name     = "main"
  schema_name      = "ml_models"
  storage_location = "s3://my-bucket/models/fraud-detection"
  
  tags = {
    team        = "data_science"
    environment = "production"
  }

  permissions = [
    {
      principal  = "data_scientists"
      privileges = ["READ", "WRITE"]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| model_name | Name of the MLflow model | `string` | n/a | yes |
| description | Description of the MLflow model | `string` | `null` | no |
| catalog_name | Name of the Unity Catalog where the model will be registered | `string` | n/a | yes |
| schema_name | Name of the schema where the model will be registered | `string` | n/a | yes |
| storage_location | Storage location for the model artifacts | `string` | `null` | no |
| tags | Tags to be applied to the model | `map(string)` | `null` | no |
| permissions | Permissions configuration for the model | `list(object)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| model_id | The ID of the registered MLflow model |
| model_name | The name of the MLflow model |
| catalog_name | The name of the catalog containing the model |
| schema_name | The name of the schema containing the model |
| storage_location | The storage location of the model artifacts |