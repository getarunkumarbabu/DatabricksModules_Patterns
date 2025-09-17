# Databricks MLflow Model Module

This module manages MLflow models in Databricks, allowing you to track and version machine learning models.

## Usage

```hcl
module "mlflow_model" {
  source = "./modules/databricks_mlflow_model"

  name        = "my-model"
  description = "My MLflow model for production use"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the MLflow model | `string` | n/a | yes |
| description | Description of the MLflow model | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| model_id | The ID of the MLflow model |
| model | The full MLflow model resource |