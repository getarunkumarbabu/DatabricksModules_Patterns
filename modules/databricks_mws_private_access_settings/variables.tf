
variable "private_access_settings_name" {
  description = "Name of the private access settings configuration"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.private_access_settings_name))
    error_message = "The private_access_settings_name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "region" {
  description = "Azure region where the private access settings will be configured"
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "The region must not be empty."
  }
}

variable "public_access_enabled" {
  description = "Whether public access should be enabled"
  type        = bool
  default     = false
}