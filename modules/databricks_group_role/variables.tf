variable "group_name" {
  description = "Name of the Databricks group"
  type        = string
  validation {
    condition     = length(var.group_name) > 0
    error_message = "The group_name cannot be empty."
  }
}

variable "workspace_access" {
  description = "Whether to grant workspace access to the group"
  type        = bool
  default     = true
}

variable "roles" {
  description = "List of roles to assign to the group"
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