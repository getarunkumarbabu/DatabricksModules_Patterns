variable "alert_name" {
  description = "The name of the SQL alert. Must be unique within the workspace."
  type        = string
}

variable "query_id" {
  description = "ID of the SQL query that powers this alert. The query must return numerical or boolean data for comparison."
  type        = string
}

variable "rearm" {
  description = "Number of seconds to wait after an alert triggers before triggering again. Minimum: 300 (5 minutes)."
  type        = number
  default     = 300

  validation {
    condition     = var.rearm >= 300
    error_message = "Rearm duration must be at least 300 seconds (5 minutes)."
  }
}

variable "parent" {
  description = "Parent object ID for the alert. Used when attaching the alert to a dashboard or folder."
  type        = string
  default     = null
}

variable "dashboard_id" {
  description = "ID of the dashboard this alert belongs to. When set, the alert will be associated with this dashboard."
  type        = string
  default     = null
}

variable "options" {
  description = "Additional options for the alert configuration. Common options include: mute_alerts_after_dismiss, require_all_conditions"
  type        = map(string)
  default     = {}
}

variable "alert_conditions" {
  description = "List of alert conditions that must be met to trigger the alert. At least one condition is required."
  type = list(object({
    column           = string       # The column name from the query result to monitor
    operator         = string       # Comparison operator: >, <, =, !=, >=, <=
    value            = string       # The threshold value to compare against
    data_type        = string       # One of: number, string, datetime, boolean
    custom_data_type = optional(string) # Custom data type for special cases
  }))

  validation {
    condition = alltrue([
      for c in var.alert_conditions : contains([">", "<", "=", "!=", ">=", "<="], c.operator)
    ])
    error_message = "Alert condition operators must be one of: >, <, =, !=, >=, <="
  }

  validation {
    condition = alltrue([
      for c in var.alert_conditions : contains(["number", "string", "datetime", "boolean"], c.data_type)
    ])
    error_message = "Alert condition data_type must be one of: number, string, datetime, boolean"
  }

  validation {
    condition     = length(var.alert_conditions) > 0
    error_message = "At least one alert condition must be provided"
  }
}

variable "notification_settings" {
  description = "Configuration for alert notifications across different channels"
  type = object({
    custom_subject = optional(string)       # Custom email subject line
    custom_body    = optional(string)       # Custom notification message
    emails         = optional(list(string)) # List of email addresses to notify
    xmatters       = optional(bool)         # Enable xMatters notifications
    slack          = optional(object({      # Slack notification settings
      channels     = optional(list(string)) # Slack channels to notify
      workspace_id = optional(string)       # Slack workspace ID
    }))
    teams          = optional(object({      # Microsoft Teams settings
      webhook_url  = optional(string)       # Teams webhook URL
      channel      = optional(string)       # Teams channel name
    }))
    webhook        = optional(object({      # Custom webhook settings
      url          = string                 # Webhook URL
      headers      = optional(map(string))  # Custom headers
      template     = optional(string)       # Message template
    }))
  })
  default = null

  validation {
    condition     = var.notification_settings == null || can([var.notification_settings.emails == null || length(coalesce(var.notification_settings.emails, [])) > 0])
    error_message = "If emails are provided, at least one email address is required."
  }

  validation {
    condition     = var.notification_settings == null || can([var.notification_settings.webhook == null || (var.notification_settings.webhook != null && var.notification_settings.webhook.url != null)])
    error_message = "If webhook is configured, URL is required."
  }
}