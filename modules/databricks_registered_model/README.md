# Databricks Registered Model Module

This module manages MLflow registered models in Databricks Unity Catalog.

## Usage

```hcl
module "example_model" {
  source = "./modules/databricks_registered_model"

  model_name = "fraud_detection_model"
  catalog_name = "main"
  schema_name = "ml_models"
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
| catalog_name | Name of the Unity Catalog where the model will be registered | `string` | n/a | yes |
| schema_name | Name of the schema where the model will be registered | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| model_id | The ID of the registered MLflow model |
| model_name | The name of the MLflow model |
| catalog_name | The name of the catalog containing the model |
| schema_name | The name of the schema containing the model |