# Variables for Databricks Azure AD Group module

variable "group_display_name" {
  description = "The display name of the Azure AD group"
  type        = string
}

variable "group_external_id" {
  description = "The external ID of the Azure AD group (Azure AD Object ID)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$", var.group_external_id))
    error_message = "The group_external_id must be a valid UUID format (Azure AD Object ID)."
  }
}

variable "role" {
  description = "The role to assign to the group (admin or user)"
  type        = string
  
  validation {
    condition     = contains(["admin", "user"], var.role)
    error_message = "Role must be either 'admin' or 'user'."
  }
}

variable "workspace_access" {
  description = "Whether to grant workspace access to the group"
  type        = bool
  default     = true
}