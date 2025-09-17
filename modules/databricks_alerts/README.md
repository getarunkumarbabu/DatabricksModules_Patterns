# Databricks SQL Alerts Module

This module manages Databricks SQL alerts for monitoring query results and sending notifications across multiple channels.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| databricks | >= 1.0.0 |

## Usage

### Basic Alert with Email Notification

```hcl
module "error_rate_alert" {
  source = "./modules/databricks_alerts"

  alert_name = "high_error_rate_alert"
  query_id   = "123-456-789"
  rearm      = 300  # 5 minutes

  alert_conditions = [{
    column    = "error_rate"
    operator  = ">"
    value     = "0.05"
    data_type = "number"
  }]

  notification_settings = {
    custom_subject = "High Error Rate Detected"
    custom_body    = "Error rate has exceeded threshold of 5%"
    emails         = ["team@example.com"]
  }
}
```

### Multiple Conditions with Slack and Teams Notifications

```hcl
module "system_health_alert" {
  source = "./modules/databricks_alerts"

  alert_name = "system_health_alert"
  query_id   = "987-654-321"
  rearm      = 600  # 10 minutes

  alert_conditions = [
    {
      column    = "cpu_usage"
      operator  = ">"
      value     = "90"
      data_type = "number"
    },
    {
      column    = "memory_available"
      operator  = "<"
      value     = "1000"
      data_type = "number"
    }
  ]

  notification_settings = {
    custom_subject = "System Health Alert"
    slack = {
      channels     = ["#alerts", "#oncall"]
      workspace_id = "T12345678"
    }
    teams = {
      webhook_url = "https://outlook.office.com/webhook/..."
      channel     = "Alerts"
    }
  }

  options = {
    "require_all_conditions" = "true"
  }
}
```

### Complex Alert with Custom Webhook

```hcl
module "business_metric_alert" {
  source = "./modules/databricks_alerts"

  alert_name = "revenue_anomaly_alert"
  query_id   = "456-789-123"
  rearm      = 3600  # 1 hour

  alert_conditions = [
    {
      column    = "revenue_change"
      operator  = ">"
      value     = "20"
      data_type = "number"
    },
    {
      column           = "anomaly_score"
      operator         = ">"
      value           = "0.95"
      data_type       = "number"
      custom_data_type = "probability"
    }
  ]

  notification_settings = {
    custom_subject = "Revenue Anomaly Detected"
    custom_body    = <<-EOT
      Revenue change alert:
      - Change percentage: {{revenue_change}}%
      - Anomaly score: {{anomaly_score}}
      - Timestamp: {{timestamp}}
    EOT
    
    emails = ["finance@example.com", "data@example.com"]
    
    webhook = {
      url = "https://api.example.com/alerts"
      headers = {
        "Authorization" = "Bearer {{secrets.ALERT_TOKEN}}"
        "Content-Type"  = "application/json"
      }
      template = jsonencode({
        severity    = "high"
        metric      = "revenue"
        change      = "{{revenue_change}}"
        score       = "{{anomaly_score}}"
        alert_id    = "{{alert_id}}"
        alert_name  = "{{alert_name}}"
      })
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert_name | The name of the SQL alert. Must be unique within the workspace | `string` | - | yes |
| query_id | ID of the SQL query that powers this alert | `string` | - | yes |
| rearm | Time in seconds to wait before re-triggering (min: 300s) | `number` | `300` | no |
| parent | Parent object ID for the alert | `string` | `null` | no |
| options | Additional alert options (see below) | `map(string)` | `{}` | no |
| alert_conditions | List of conditions that trigger the alert (see below) | `list(object)` | - | yes |
| notification_settings | Notification configuration (see below) | `object` | `null` | no |

### Alert Conditions

```hcl
list(object({
  column           = string       # Column name from query result
  operator         = string       # One of: >, <, =, !=, >=, <=
  value            = string       # Threshold value
  data_type        = string       # One of: number, string, datetime, boolean
  custom_data_type = string       # Optional custom type
}))
```

### Notification Settings

```hcl
object({
  custom_subject = string         # Optional custom email subject
  custom_body    = string         # Optional custom message body
  emails         = list(string)   # Email addresses
  xmatters       = bool          # Enable xMatters
  slack = object({
    channels     = list(string)  # Slack channels
    workspace_id = string        # Slack workspace ID
  })
  teams = object({
    webhook_url = string         # Teams webhook URL
    channel     = string         # Teams channel
  })
  webhook = object({
    url      = string           # Webhook URL
    headers  = map(string)      # Custom headers
    template = string           # Message template
  })
})
```

### Options

Common options include:
- `mute_alerts_after_dismiss` - Mute similar alerts after dismissing
- `require_all_conditions` - Require all conditions to be met

## Outputs

| Name | Description |
|------|-------------|
| alert_id | The ID of the created SQL alert |
| alert_name | The name of the SQL alert |
| alert_state | The current state of the alert |
| query_id | Associated SQL query ID |
| rearm | Configured rearm duration |
| parent | Parent object ID |
| alert_conditions | List of configured conditions |
| notification_settings | Notification configuration (sensitive) |
| alert_summary | Summary of alert configuration |

## Alert Types and Best Practices

### 1. Metric Monitoring
- Use for tracking KPIs and metrics
- Set appropriate thresholds based on historical data
- Consider using multiple conditions for better accuracy

### 2. Error Detection
- Monitor error rates and exceptions
- Set lower thresholds for critical systems
- Use custom messages with detailed error information

### 3. Business Anomalies
- Monitor business metrics for unusual patterns
- Combine with anomaly detection scores
- Use custom webhooks for advanced integrations

### 4. System Health
- Monitor resource utilization
- Set graduated thresholds
- Use different notification channels based on severity

## Notification Best Practices

1. **Email Notifications**
   - Use clear subjects
   - Include relevant context
   - Consider notification frequency

2. **Slack Integration**
   - Use dedicated channels
   - Include actionable information
   - Consider using mentions

3. **Microsoft Teams**
   - Use webhook URLs securely
   - Format messages for readability
   - Consider thread continuity

4. **Custom Webhooks**
   - Implement proper authentication
   - Handle errors gracefully
   - Include correlation IDs

## Troubleshooting

1. **Alert Not Triggering**
   - Verify query returns expected data
   - Check condition thresholds
   - Confirm rearm duration

2. **Notification Issues**
   - Verify channel configurations
   - Check permissions and tokens
   - Monitor webhook responses

3. **Performance Considerations**
   - Optimize underlying queries
   - Set appropriate rearm intervals
   - Monitor alert execution time