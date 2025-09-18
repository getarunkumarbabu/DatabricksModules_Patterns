variable "name" {
  description = "Name of the init script"
  type        = string
}

variable "content" {
  description = "Content of the init script. Required if source and source_path are not provided"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the init script is enabled"
  type        = bool
  default     = true
}

variable "position" {
  description = "Position of the init script (determines execution order). Lower numbers run first"
  type        = number
  default     = null
}

variable "source" {
  description = "Source path in DBFS for an existing init script"
  type        = string
  default     = null
}

variable "source_path" {
  description = "Local path to the init script file to be uploaded. Content will be read from this file"
  type        = string
  default     = null
}

locals {
  # Validation: exactly one of content, source, or source_path must be provided
  validate_content = (var.content != null ? 1 : 0) + (var.source != null ? 1 : 0) + (var.source_path != null ? 1 : 0)
  validate_error   = local.validate_content == 1 ? null : file("ERROR: Exactly one of content, source, or source_path must be provided")
}