variable "storage_configuration_name" {
  description = "Name of the storage configuration"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.storage_configuration_name))
    error_message = "The storage_configuration_name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "account_id" {
  description = "Databricks account ID"
  type        = string
  validation {
    condition     = can(regex("^[0-9]+$", var.account_id))
    error_message = "The account_id must be a numeric string."
  }
}

variable "container_name" {
  description = "Azure storage container name"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.container_name))
    error_message = "The container_name can only contain lowercase letters, numbers, and hyphens."
  }
}