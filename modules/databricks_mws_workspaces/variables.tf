variable "workspace_name" {
  description = "Name of the workspace"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.workspace_name))
    error_message = "The workspace_name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "deployment_name" {
  description = "Name of the deployment"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.deployment_name))
    error_message = "The deployment_name can only contain alphanumeric characters, hyphens, and underscores."
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

variable "network_id" {
  description = "ID of the network configuration to use"
  type        = string
}

variable "storage_configuration_id" {
  description = "ID of the storage configuration to use"
  type        = string
}

variable "credentials_id" {
  description = "ID of the credentials configuration to use"
  type        = string
}

variable "location" {
  description = "Azure region for the workspace"
  type        = string
}

variable "pricing_tier" {
  description = "Pricing tier of the workspace (STANDARD or PREMIUM)"
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "PREMIUM"], var.pricing_tier)
    error_message = "The pricing_tier must be either STANDARD or PREMIUM."
  }
}

variable "managed_resource_group" {
  description = "Name of the managed resource group"
  type        = string
  default     = null
}