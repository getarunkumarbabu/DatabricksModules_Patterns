variable "account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "config_name" {
  description = "Name of the log delivery configuration"
  type        = string
}

variable "storage_configuration_id" {
  description = "ID of the storage configuration to use"
  type        = string
}

variable "log_type" {
  description = "Type of logs to deliver (e.g., BILLABLE_USAGE, AUDIT_LOGS)"
  type        = string
  validation {
    condition     = contains(["BILLABLE_USAGE", "AUDIT_LOGS"], var.log_type)
    error_message = "Log type must be either BILLABLE_USAGE or AUDIT_LOGS."
  }
}

variable "output_format" {
  description = "Format of the log output (e.g., JSON, CSV)"
  type        = string
  default     = "JSON"
  validation {
    condition     = contains(["JSON", "CSV"], var.output_format)
    error_message = "Output format must be either JSON or CSV."
  }
}

variable "delivery_path_prefix" {
  description = "Prefix path where logs will be delivered"
  type        = string
}

variable "delivery_start_time" {
  description = "Start time for log delivery (RFC3339 format)"
  type        = string
}

variable "status" {
  description = "Status of the log delivery configuration"
  type        = string
  default     = "ENABLED"
  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.status)
    error_message = "Status must be either ENABLED or DISABLED."
  }
}

variable "credentials_id" {
  description = "ID of the credentials to use for log delivery"
  type        = string
}