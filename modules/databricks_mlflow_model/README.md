# Databricks MLflow Model Module

This module creates an MLflow model in Databricks.

## Example Usage

```hcl
module "mlflow_model" {
  source = "./modules/databricks_mlflow_model"

  name        = "my-model"
  description = "My MLflow model"
  labels      = ["production", "ml"]
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
| [databricks_mlflow_model.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mlflow_model) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the MLflow model | string | n/a | yes |
| description | Description of the MLflow model | string | null | no |
| labels | Labels to be applied to the MLflow model | list(string) | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the MLflow model |
| latest_versions | Latest versions of the MLflow model |