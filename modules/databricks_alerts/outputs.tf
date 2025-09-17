output "alert_id" {
  description = "The ID of the created SQL alert"
  value       = databricks_sql_alert.this.id
}

output "alert_name" {
  description = "The name of the SQL alert"
  value       = databricks_sql_alert.this.name
}

output "alert_state" {
  description = "The current state of the alert"
  value       = databricks_sql_alert.this.state
}

output "query_id" {
  description = "The ID of the SQL query associated with this alert"
  value       = databricks_sql_alert.this.query_id
}

output "rearm" {
  description = "The number of seconds to wait before re-triggering the alert"
  value       = databricks_sql_alert.this.rearm
}

output "parent" {
  description = "The parent object ID this alert is associated with"
  value       = databricks_sql_alert.this.parent
}

output "alert_conditions" {
  description = "The configured alert conditions"
  value       = [
    for condition in databricks_sql_alert.this.alert_condition : {
      column           = condition.column
      operator         = condition.operator
      value           = condition.value
      data_type       = condition.data_type
      custom_data_type = condition.custom_data_type
    }
  ]
}

output "notification_settings" {
  description = "The configured notification settings"
  value = var.notification_settings != null ? {
    custom_subject = try(databricks_sql_alert.this.notification_settings[0].custom_subject, null)
    custom_body    = try(databricks_sql_alert.this.notification_settings[0].custom_body, null)
    emails        = try(databricks_sql_alert.this.notification_settings[0].emails, null)
    xmatters      = try(databricks_sql_alert.this.notification_settings[0].xmatters, null)
    slack         = local.slack_config
    teams         = local.teams_config
    webhook       = local.webhook_config
  } : null
  sensitive = true # Because it might contain sensitive information like webhook URLs and credentials
}

output "alert_summary" {
  description = "A summary of the alert configuration and state"
  value = {
    id            = databricks_sql_alert.this.id
    name          = databricks_sql_alert.this.name
    state         = databricks_sql_alert.this.state
    query_id      = databricks_sql_alert.this.query_id
    rearm_seconds = databricks_sql_alert.this.rearm
    conditions    = length(databricks_sql_alert.this.alert_condition)
    notifications = var.notification_settings != null ? {
      has_email    = try(length(var.notification_settings.emails) > 0, false)
      has_slack    = try(var.notification_settings.slack != null, false)
      has_teams    = try(var.notification_settings.teams != null, false)
      has_webhook  = try(var.notification_settings.webhook != null, false)
      has_xmatters = try(var.notification_settings.xmatters, false)
    } : null
  }
}