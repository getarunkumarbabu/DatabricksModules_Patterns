# Databricks SQL Dashboard Module

This module manages SQL dashboards in Databricks, allowing you to create and organize analytics dashboards.

## Features

- Create and manage SQL dashboards
- Organize dashboards in folders
- Add tags for categorization
- Link to SQL warehouses
- Custom dashboard descriptions

## Usage

```hcl
module "analytics_dashboard" {
  source = "./modules/databricks_sql_dashboard"

  name         = "Marketing Analytics"
  description  = "Key marketing metrics and KPIs"
  warehouse_id = databricks_sql_warehouse.analytics.id
  tags = {
    department = "marketing"
    environment = "production"
  }
}
```

## Examples

### Basic Dashboard

```hcl
module "sales_dashboard" {
  source = "./modules/databricks_sql_dashboard"

  name         = "Sales Overview"
  warehouse_id = databricks_sql_warehouse.bi.id
}
```

### Organized Dashboard

```hcl
module "finance_dashboard" {
  source = "./modules/databricks_sql_dashboard"

  name         = "Financial Reports"
  description  = "Monthly financial analysis and reports"
  warehouse_id = databricks_sql_warehouse.finance.id
  parent       = databricks_folder.finance_reports.id
  tags = {
    department = "finance"
    frequency  = "monthly"
  }
}
```

## Requirements

- Databricks provider configured with workspace access
- SQL warehouse for running queries
- Appropriate permissions to create dashboards

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the SQL dashboard | `string` | n/a | yes |
| warehouse_id | ID of the SQL warehouse to use | `string` | n/a | yes |
| tags | Tags for categorization | `map(string)` | `{}` | no |
| description | Description of the dashboard | `string` | `null` | no |
| parent | Parent folder ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dashboard_id | The unique identifier for the dashboard |
| dashboard_url | The URL to access the dashboard |
| dashboard_name | The name of the dashboard |
| dashboard_tags | The tags associated with the dashboard |
| created_at | The timestamp when the dashboard was created |
| updated_at | The timestamp when the dashboard was last updated |

## Notes

1. Dashboards require an active SQL warehouse
2. Visualizations must be added separately
3. Dashboard permissions are inherited from the parent folder
4. Tags help with organization and discovery

## Best Practices

1. Use clear, descriptive names
2. Organize dashboards in logical folders
3. Add meaningful descriptions
4. Use consistent tagging conventions
5. Link to appropriate SQL warehouses