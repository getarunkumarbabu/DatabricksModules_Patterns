variable "user_name" {
  description = "Email address of the user"
  type        = string
  validation {
    condition     = can(regex("^[^@]+@[^@]+\\.[^@]+$", var.user_name))
    error_message = "The user_name must be a valid email address."
  }
}

variable "workspace_access" {
  description = "Whether to grant workspace access"
  type        = bool
  default     = true
}

variable "display_name" {
  description = "Display name for the user"
  type        = string
  default     = null
}

variable "roles" {
  description = "List of roles to assign to the user"
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