variable "service_principal_name" {
  description = "Display name for the service principal"
  type        = string
  validation {
    condition     = length(var.service_principal_name) > 0
    error_message = "The service_principal_name cannot be empty."
  }
}

variable "application_id" {
  description = "Application (client) ID of the service principal"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.application_id))
    error_message = "The application_id must be a valid UUID."
  }
}

variable "workspace_access" {
  description = "Whether to grant workspace access"
  type        = bool
  default     = true
}

variable "roles" {
  description = "List of roles to assign to the service principal"
  type        = list(string)
  validation {
    condition = alltrue([
      for role in var.roles :
      contains([
        "admin",
        "user",
        "account_admin",
        "cluster_admin",
        "workspace_admin",
        "token_admin",
        "notebook_admin"
      ], role)
    ])
    error_message = "Each role must be one of: admin, user, account_admin, cluster_admin, workspace_admin, token_admin, notebook_admin."
  }
}