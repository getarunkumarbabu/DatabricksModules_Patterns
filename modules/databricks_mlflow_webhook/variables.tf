variable "events" {
  description = "List of events that trigger the webhook (e.g., MODEL_VERSION_CREATED, REGISTERED_MODEL_CREATED)"
  type        = list(string)
}

variable "description" {
  description = "Description of the webhook's purpose"
  type        = string
  default     = null
}

variable "status" {
  description = "Status of the webhook (ACTIVE or DISABLED)"
  type        = string
  default     = "ACTIVE"

  validation {
    condition     = contains(["ACTIVE", "DISABLED"], var.status)
    error_message = "Status must be either ACTIVE or DISABLED."
  }
}

variable "url" {
  description = "The URL to send the webhook request to"
  type        = string
}

variable "enable_ssl_verification" {
  description = "Whether to verify SSL certificates for HTTPS requests"
  type        = bool
  default     = true
}

variable "authorization" {
  description = "Authorization header value for webhook requests"
  type        = string
  default     = null
  sensitive   = true
}

variable "job_spec" {
  description = "Configuration for triggering a Databricks job"
  type = object({
    job_id       = string
    workspace    = optional(string)
    access_token = optional(string)
  })
  default = null
}

variable "http_url_spec" {
  description = "Configuration for HTTP webhook endpoint"
  type = object({
    url                     = string
    enable_ssl_verification = optional(bool, true)
    authorization_header    = optional(string)
  })
  default = null
}

variable "registry_webhook" {
  description = "Whether this is a registry webhook"
  type        = bool
  default     = true
}