# Databricks Notebook Module

This module manages notebooks in the Databricks workspace, allowing you to create and configure notebooks from various sources.

## Usage

### Basic Usage

```hcl
module "notebook" {
  source = "./modules/databricks_notebook"

  path     = "/Shared/my-notebook"
  language = "PYTHON"
  source   = "https://raw.githubusercontent.com/example/notebook.py"
  format   = "SOURCE"
}
```

### With Cluster Attachment

```hcl
module "notebook" {
  source = "./modules/databricks_notebook"

  path       = "/Shared/my-notebook"
  language   = "PYTHON"
  source     = "https://raw.githubusercontent.com/example/notebook.py"
  format     = "SOURCE"
  cluster_id = databricks_cluster.example.id
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
| path | The path where the notebook will be stored in the workspace | `string` | n/a | yes |
| language | The language of the notebook (PYTHON, R, SCALA, SQL) | `string` | n/a | yes |
| source | The source URL or path of the notebook | `string` | n/a | yes |
| format | The format of the notebook (SOURCE, HTML, JUPYTER, DBC) | `string` | `"SOURCE"` | no |
| cluster_id | The ID of the cluster to attach the notebook to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| notebook_id | The ID of the notebook |
| notebook_url | The URL of the notebook |
| notebook | The full notebook resource |

## Notes

1. The notebook path must be absolute and start with a slash (/).
2. Supported languages:
   - PYTHON
   - R
   - SCALA
   - SQL

3. Supported formats:
   - SOURCE: Plain source format
   - HTML: HTML export format
   - JUPYTER: Jupyter notebook format
   - DBC: Databricks archive format

4. The source can be:
   - A URL pointing to raw notebook content
   - A local file path
   - Base64-encoded content

5. If cluster_id is provided, the notebook will be attached to that cluster.