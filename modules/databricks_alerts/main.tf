locals {
  # Process notification channel configurations
  slack_config = try({
    enabled      = var.notification_settings.slack != null
    channels     = try(var.notification_settings.slack.channels, [])
    workspace_id = try(var.notification_settings.slack.workspace_id, null)
  }, null)

  teams_config = try({
    enabled     = var.notification_settings.teams != null
    webhook_url = try(var.notification_settings.teams.webhook_url, null)
    channel     = try(var.notification_settings.teams.channel, null)
  }, null)

  webhook_config = try({
    url      = try(var.notification_settings.webhook.url, null)
    headers  = try(var.notification_settings.webhook.headers, {})
    template = try(var.notification_settings.webhook.template, null)
  }, null)
}

resource "databricks_sql_alert" "this" {
  name      = var.alert_name
  query_id  = var.query_id
  rearm     = var.rearm
  parent    = var.parent

  dynamic "options" {
    for_each = var.options
    content {
      column = options.key
      op     = "="
      value  = options.value
    }
  }

  # Alert conditions with improved error handling
  dynamic "alert_condition" {
    for_each = var.alert_conditions
    content {
      column           = alert_condition.value.column
      operator         = alert_condition.value.operator
      value           = alert_condition.value.value
      data_type       = alert_condition.value.data_type
      custom_data_type = try(alert_condition.value.custom_data_type, null)
    }
  }

  # Notification settings with enhanced channel configuration
  dynamic "notification_settings" {
    for_each = var.notification_settings != null ? [var.notification_settings] : []
    content {
      custom_subject = try(notification_settings.value.custom_subject, null)
      custom_body    = try(notification_settings.value.custom_body, null)
      emails        = try(notification_settings.value.emails, null)
      xmatters      = try(notification_settings.value.xmatters, false)
      
      # Slack configuration
      dynamic "slack" {
        for_each = local.slack_config != null ? [local.slack_config] : []
        content {
          channels     = slack.value.channels
          workspace_id = slack.value.workspace_id
        }
      }
      
      # Microsoft Teams configuration
      dynamic "teams" {
        for_each = local.teams_config != null ? [local.teams_config] : []
        content {
          webhook_url = teams.value.webhook_url
          channel     = teams.value.channel
        }
      }
      
      # Webhook configuration
      dynamic "webhook" {
        for_each = local.webhook_config != null ? [local.webhook_config] : []
        content {
          url      = webhook.value.url
          headers  = webhook.value.headers
          template = webhook.value.template
        }
      }
    }
  }

  # Lifecycle management for associated resources
  lifecycle {
    ignore_changes = [
      parent  # Ignore parent changes for dashboard/folder moves
    ]
  }
}