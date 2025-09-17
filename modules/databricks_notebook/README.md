# Databricks Notebook Module

This module creates and manages notebooks in Databricks workspace.

## Example Usage

```hcl
module "notebook" {
  source = "./modules/databricks_notebook"

  path     = "/path/to/notebook"
  language = "PYTHON"
  source   = "local/path/to/notebook.py"
  format   = "SOURCE"

  cluster = {
    num_workers = 2
    cluster_id  = "existing-cluster-id"
  }
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
| [databricks_notebook.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/notebook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| path | Path to the notebook in the workspace | string | n/a | yes |
| language | Language of the notebook (SCALA, PYTHON, SQL, or R) | string | n/a | yes |
| source | Source path in the local filesystem or URL | string | null | no |
| format | Format of the notebook (SOURCE, HTML, JUPYTER, DBC) | string | "SOURCE" | no |
| content_base64 | Base64 encoded content of the notebook | string | null | no |
| cluster | Cluster configuration for the notebook | object | null | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the notebook |
| url | URL of the notebook in the Databricks workspace |