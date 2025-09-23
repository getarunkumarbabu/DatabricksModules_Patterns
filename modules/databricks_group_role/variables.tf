# =============================================================================
# Databricks Group Role Assignment Variables
# =============================================================================

# ------------------------------------------------------------------------------
# Group Configuration
# ------------------------------------------------------------------------------
variable "group_name" {
  description = "Display name of the Databricks group"
  type        = string

  validation {
    condition     = length(var.group_name) > 0
    error_message = "The group_name cannot be empty."
  }
}

variable "external_id" {
  description = "External ID of the group (useful for Azure AD integration). If provided, this indicates the group is managed externally."
  type        = string
  default     = null
}

# ------------------------------------------------------------------------------
# Access Permissions
# ------------------------------------------------------------------------------
variable "workspace_access" {
  description = "Whether to grant workspace access to the group (legacy - consider using allow_* variables instead)"
  type        = bool
  default     = true
}

variable "allow_cluster_create" {
  description = "Whether the group can create clusters"
  type        = bool
  default     = false
}

variable "databricks_sql_access" {
  description = "Whether the group has Databricks SQL access"
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# Role Assignments
# ------------------------------------------------------------------------------
variable "roles" {
  description = "List of roles to assign to the group"
  type        = list(string)
  default     = []

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
        "notebook_admin",
        "sql_admin",
        "job_admin",
        "mlflow_admin",
        "feature_store_admin"
      ], role)
    ])
    error_message = "Each role must be one of: admin, user, account_admin, cluster_admin, workspace_admin, token_admin, notebook_admin, sql_admin, job_admin, mlflow_admin, feature_store_admin."
  }
}

# ------------------------------------------------------------------------------
# Group Members (Optional)
# ------------------------------------------------------------------------------
variable "member_user_ids" {
  description = "List of user IDs to add as direct members of the group (optional - for direct member management)"
  type        = list(string)
  default     = []
}

# ------------------------------------------------------------------------------
# Lifecycle Management
# ------------------------------------------------------------------------------
variable "force_delete_group" {
  description = "Whether to force delete the group even if it has members (use with caution)"
  type        = bool
  default     = false
}