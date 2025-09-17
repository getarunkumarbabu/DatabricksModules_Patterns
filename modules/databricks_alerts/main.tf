resource "databricks_sql_alert" "this" {
  name         = var.alert_name
  sql_query_id = var.query_id
  rearm        = var.rearm

  dynamic "alert_condition" {
    for_each = var.alert_conditions
    content {
      column    = alert_condition.value.column
      operator  = alert_condition.value.operator
      value     = alert_condition.value.value
      data_type = alert_condition.value.data_type
    }
  }

  dynamic "notification_settings" {
    for_each = var.notification_settings != null ? [var.notification_settings] : []
    content {
      emails = notification_settings.value.emails
      xmatters = notification_settings.value.xmatters
      slack = notification_settings.value.slack
      teams = notification_settings.value.teams
      webhook = notification_settings.value.webhook
    }
  }
}