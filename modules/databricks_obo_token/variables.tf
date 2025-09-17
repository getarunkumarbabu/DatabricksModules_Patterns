variable "application_id" {
  description = "The application ID for which to generate the on-behalf-of token"
  type        = string
}

variable "comment" {
  description = "Comment describing the purpose of the token"
  type        = string
  default     = null
}

variable "lifetime_seconds" {
  description = "The lifetime of the token in seconds"
  type        = number
  default     = 3600  # 1 hour

  validation {
    condition     = var.lifetime_seconds > 0 && var.lifetime_seconds <= 864000
    error_message = "Token lifetime must be between 1 second and 864000 seconds (10 days)."
  }
}