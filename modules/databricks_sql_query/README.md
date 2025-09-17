# Databricks SQL Query Module

This module manages SQL queries using the `databricks_sql_query` resource.

## Inputs

- `name` (string) - Query name
- `data_source_id` (string) - Data source ID
- `query` (string) - SQL query text
- `schedule_interval_seconds` (number, optional) - Schedule interval
- `schedule_timezone` (string, optional) - Schedule timezone
- `schedule_paused` (bool, optional) - Schedule pause state
- `tags` (map, optional) - Query tags

## Outputs

- `query_id` - ID of the query
- `query_url` - URL to query in UI

## Example

```hcl
module "daily_report" {
  source = "../modules/databricks_sql_query"
  
  name           = "Daily Sales Report"
  data_source_id = "abc123"
  
  query = <<-EOT
    SELECT date_trunc('day', order_date) as day,
           sum(amount) as daily_total
    FROM sales
    GROUP BY 1
    ORDER BY 1 DESC
  EOT
  
  schedule_interval_seconds = 86400  # Daily
  schedule_timezone        = "America/Los_Angeles"
  
  tags = {
    team = "analytics"
    env  = "prod"
  }
}
```

## Notes

- Queries can be scheduled or run on-demand
- Use parameterized queries for flexibility
- Consider timezone when scheduling
- Tag queries for organization
- Query history and results are stored in Databricks