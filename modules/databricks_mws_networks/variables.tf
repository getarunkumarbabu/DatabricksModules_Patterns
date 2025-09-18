variable "account_id" {
  description = "Databricks account ID"
  type        = string
  validation {
    condition     = can(regex("^[0-9]+$", var.account_id))
    error_message = "The account_id must be a numeric string."
  }
}

variable "network_name" {
  description = "Name of the network configuration"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.network_name))
    error_message = "The network_name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "workspace_id" {
  description = "ID of the workspace to associate with this network"
  type        = string
  validation {
    condition     = length(var.workspace_id) > 0
    error_message = "The workspace_id cannot be empty."
  }
}