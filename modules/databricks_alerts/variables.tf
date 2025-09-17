variable "alert_name" {
  description = "Name of the SQL alert"
  type        = string
}

variable "query_id" {
  description = "ID of the SQL query that powers this alert"
  type        = string
}

variable "rearm" {
  description = "Number of seconds to wait after an alert triggers before triggering again"
  type        = number
  default     = 300
}

variable "alert_conditions" {
  description = "List of alert conditions that must be met to trigger the alert"
  type = list(object({
    column    = string
    operator  = string
    value     = string
    data_type = string
  }))
}

variable "notification_settings" {
  description = "Notification settings for the alert"
  type = object({
    emails   = optional(list(string))
    xmatters = optional(bool)
    slack    = optional(bool)
    teams    = optional(bool)
    webhook  = optional(string)
  })
  default = null
}