# Databricks Model Serving Module

This module manages model serving endpoints in Databricks, allowing you to deploy MLflow models for real-time inference.

## Usage

```hcl
module "model_serving" {
  source = "./modules/databricks_model_serving"

  name                 = "my-endpoint"
  model_name          = "my-model"
  model_version       = "1"
  workload_size      = "Small"
  scale_to_zero_enabled = true
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
| name | The name of the model serving endpoint | `string` | n/a | yes |
| model_name | The name of the MLflow model to serve | `string` | n/a | yes |
| model_version | The version of the MLflow model to serve | `string` | n/a | yes |
| workload_size | The workload size for the serving endpoint (Small, Medium, Large) | `string` | `"Small"` | no |
| scale_to_zero_enabled | Whether to enable scale-to-zero functionality | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| serving_endpoint_id | The ID of the model serving endpoint |
| serving_endpoint_url | The URL of the model serving endpoint |
| serving_endpoint | The full model serving endpoint resource |