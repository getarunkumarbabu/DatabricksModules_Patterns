# Databricks Alerts Module

This module manages Databricks SQL alerts for monitoring query results.

## Usage

```hcl
module "example_alert" {
  source = "./modules/databricks_alerts"

  alert_name = "high_error_rate_alert"
  query_id   = "your-query-id"
  rearm      = 300  # 5 minutes

  alert_conditions = [
    {
      column    = "error_rate"
      operator  = ">"
      value     = "0.05"
      data_type = "float"
    }
  ]

  notification_settings = {
    emails = ["team@example.com"]
    slack  = true
    teams  = false
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
| alert_name | Name of the SQL alert | `string` | n/a | yes |
| query_id | ID of the SQL query that powers this alert | `string` | n/a | yes |
| rearm | Number of seconds to wait after an alert triggers before triggering again | `number` | 300 | no |
| alert_conditions | List of alert conditions that must be met to trigger the alert | `list(object)` | n/a | yes |
| notification_settings | Notification settings for the alert | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| alert_id | The ID of the created SQL alert |
| alert_name | The name of the SQL alert |
| alert_state | The current state of the alert |