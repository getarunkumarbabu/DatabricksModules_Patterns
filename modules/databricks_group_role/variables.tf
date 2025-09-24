# ------------------------------------------------------------------------------
# Group Configuration
# ------------------------------------------------------------------------------
variable "group_name" {
  description = "Display name of the Databricks group"
  type        = string
}

variable "external_id" {
  description = "External ID for Azure AD integration (optional)"
  type        = string
  default     = null
}

# ------------------------------------------------------------------------------
# Access Permissions
# ------------------------------------------------------------------------------
variable "workspace_access" {
  description = "Grant workspace access (legacy)"
  type        = bool
  default     = true
}

variable "allow_cluster_create" {
  description = "Allow cluster creation"
  type        = bool
  default     = false
}

variable "allow_instance_pool_create" {
  description = "Allow instance pool creation"
  type        = bool
  default     = false
}

variable "databricks_sql_access" {
  description = "Grant Databricks SQL access"
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# Role Assignments
# ------------------------------------------------------------------------------
variable "roles" {
  description = "List of roles to assign"
  type        = list(string)
  default     = []
}

# ------------------------------------------------------------------------------
# Member Management
# ------------------------------------------------------------------------------
variable "member_user_ids" {
  description = "Direct user members"
  type        = list(string)
  default     = []
}

# ------------------------------------------------------------------------------
# Lifecycle Management
# ------------------------------------------------------------------------------
variable "force_delete_group" {
  description = "Force delete with members"
  type        = bool
  default     = false
}