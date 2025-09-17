variable "name" {
  description = "Name of the provider"
  type        = string
}

variable "comment" {
  description = "Comment describing the provider"
  type        = string
  default     = null
}

variable "authentication_type" {
  description = "Authentication type for the provider"
  type        = string
  validation {
    condition     = contains(["TOKEN", "OAUTH"], var.authentication_type)
    error_message = "Authentication type must be either TOKEN or OAUTH."
  }
}

variable "recipient_profile_str" {
  description = "The recipient profile configuration in JSON format"
  type        = string
}

variable "token" {
  description = "Authentication token for TOKEN authentication type"
  type        = string
  default     = null
  sensitive   = true
}

variable "delta_sharing_scope" {
  description = "Delta sharing scope configuration"
  type = object({
    scope = string
  })
  default = null
}