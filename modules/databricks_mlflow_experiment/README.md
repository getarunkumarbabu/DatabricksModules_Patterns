# Databricks MLflow Experiment Module

This module creates an MLflow experiment in Databricks.

## Example Usage

```hcl
module "mlflow_experiment" {
  source = "./modules/databricks_mlflow_experiment"

  name              = "my-experiment"
  artifact_location = "dbfs:/my/artifact/location"
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
| [databricks_mlflow_experiment.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mlflow_experiment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the MLflow experiment | string | n/a | yes |
| artifact_location | Location where artifacts for runs are stored | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the MLflow experiment |
| experiment_id | Experiment ID |