# Databricks Model Serving Module

This module creates a model serving endpoint in Databricks.

## Example Usage

```hcl
module "model_serving" {
  source = "./modules/databricks_model_serving"

  name                 = "my-endpoint"
  model_name          = "my-model"
  model_version       = "1"
  workload_size       = "Small"
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

## Resources

| Name | Type |
|------|------|
| [databricks_model_serving.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/model_serving) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the model serving endpoint | string | n/a | yes |
| model_name | Name of the model to serve | string | n/a | yes |
| model_version | Version of the model to serve | string | n/a | yes |
| workload_size | Size of the workload (Small, Medium, Large) | string | "Small" | no |
| scale_to_zero_enabled | Whether to enable scale-to-zero | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| serving_endpoint_id | ID of the model serving endpoint |
| endpoint_url | URL of the serving endpoint |