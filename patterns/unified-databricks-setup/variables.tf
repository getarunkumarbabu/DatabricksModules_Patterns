# =============================================================================
# Databricks Role Assignment Variables
# =============================================================================
# This file defines the input variables required for role assignments.
# =============================================================================

# -----------------------------------------------------------------------------
# Admin Group Variable
# -----------------------------------------------------------------------------
variable "existing_admin_group_name" {
  description = <<DESC
The name of the existing Azure AD group to be assigned admin role in Databricks.
This group must already exist in Azure AD and be synchronized with Databricks.
The group will be assigned admin privileges in Databricks.
DESC

  type = string

  validation {
    condition     = length(var.existing_admin_group_name) > 0
    error_message = "Admin group name cannot be empty."
  }
}

# -----------------------------------------------------------------------------
# User Groups Variable
# -----------------------------------------------------------------------------
variable "existing_user_group_names" {
  description = <<DESC
List of existing Azure AD group names to be assigned user role in Databricks.
These groups must already exist in Azure AD and be synchronized with Databricks.
The groups will be assigned user role and SQL access in Databricks.
DESC

  type = list(string)

  validation {
    condition     = length(var.existing_user_group_names) > 0
    error_message = "At least one user group must be specified."
  }

  validation {
    condition     = alltrue([for name in var.existing_user_group_names : length(name) > 0])
    error_message = "User group names cannot be empty."
  }
}