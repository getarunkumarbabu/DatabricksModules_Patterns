# Databricks Widget Module

This module manages SQL Widgets in Databricks dashboards.

## Usage

```hcl
module "example_widget" {
  source = "./modules/databricks_widget"

  query_id         = "123456"
  dashboard_id     = "789012"
  visualization_id = "345678"
  title           = "Monthly Revenue Trends"
  type            = "chart"
  width           = 6

  options = {
    chart_type = "line"
    x_axis     = "date"
    y_axis     = "revenue"
  }

  parameter_mappings = {
    name    = "date_range"
    type    = "date_range"
    map_to  = "date_column"
    default = "last_30_days"
    title   = "Select Date Range"
    global  = true
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| databricks | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| query_id | ID of the SQL query associated with this widget | `string` | n/a | yes |
| dashboard_id | ID of the dashboard containing this widget | `string` | n/a | yes |
| visualization_id | ID of the visualization for this widget | `string` | n/a | yes |
| title | Title of the widget | `string` | n/a | yes |
| type | Type of the widget | `string` | n/a | yes |
| width | Width of the widget | `number` | 3 | no |
| options | Configuration options for the widget | `any` | `{}` | no |
| parameter_mappings | Parameter mappings for the widget | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget_id | The ID of the created SQL widget |
| query_id | The ID of the associated SQL query |
| dashboard_id | The ID of the dashboard containing this widget |
| visualization_id | The ID of the visualization for this widget |
| title | The title of the widget |