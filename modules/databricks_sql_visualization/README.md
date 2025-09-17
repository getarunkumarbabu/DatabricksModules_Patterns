# Databricks SQL Visualization Module

This module manages SQL visualizations in Databricks SQL, allowing you to create and configure visualizations for your queries.

## Usage

```hcl
module "sql_visualization" {
  source = "./modules/databricks_sql_visualization"

  query_id     = "your_query_id"
  name         = "My Visualization"
  type         = "chart"
  description  = "A sample visualization"
  
  options = {
    chartType = "bar"
    xAxis     = "category"
    yAxis     = "value"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| databricks | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| query_id | ID of the query to which this visualization belongs | `string` | n/a | yes |
| name | Name of the visualization | `string` | n/a | yes |
| type | Type of visualization (chart, table, etc.) | `string` | n/a | yes |
| description | Description of the visualization | `string` | `null` | no |
| options | Visualization options in JSON format | `map(any)` | `{}` | no |
| query_plan | Query plan for the visualization in JSON format | `map(any)` | `null` | no |
| query | Query configuration for the visualization | `object({id = string})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| visualization_id | ID of the created SQL visualization |
| visualization_url | URL of the created SQL visualization |

## Example: Chart Visualization

```hcl
module "bar_chart_visualization" {
  source = "./modules/databricks_sql_visualization"

  query_id    = "12345"
  name        = "Sales by Region"
  type        = "chart"
  description = "Bar chart showing sales distribution by region"
  
  options = {
    chartType    = "bar"
    xAxis        = "region"
    yAxis        = "total_sales"
    stacking     = "normal"
    showLegend   = true
    showDataLabels = true
  }
}
```

## Example: Table Visualization

```hcl
module "table_visualization" {
  source = "./modules/databricks_sql_visualization"

  query_id    = "67890"
  name        = "Detailed Sales Data"
  type        = "table"
  description = "Detailed table view of sales data"
  
  options = {
    itemsPerPage = 25
    sortColumn   = "date"
    sortOrder    = "desc"
  }
}
```