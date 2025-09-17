# Databricks MLflow Experiment Module

This module manages MLflow experiments in Databricks, allowing you to organize and track machine learning experiments.

## Usage

```hcl
module "mlflow_experiment" {
  source = "./modules/databricks_mlflow_experiment"

  name              = "/my-experiment"
  description       = "My MLflow experiment for model training"
  artifact_location = "dbfs:/my-artifacts/experiment1"
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
| name | The name of the MLflow experiment | `string` | n/a | yes |
| description | Description of the MLflow experiment | `string` | `null` | no |
| artifact_location | The location to store run artifacts | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| experiment_id | The ID of the MLflow experiment |
| experiment | The full MLflow experiment resource |