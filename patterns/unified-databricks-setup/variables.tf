# =============================================================================
# Unified Databricks Group Role Assignment Variables
# =============================================================================

# -----------------------------------------------------------------------------
# Databricks Authentication Configuration
# -----------------------------------------------------------------------------
variable "databricks_host" {
  description = "Databricks workspace URL (e.g., https://adb-1234567890123456.12.azuredatabricks.net)"
  type        = string

  validation {
    condition     = can(regex("^https://adb-[0-9]+\\.[0-9]+\\.azuredatabricks\\.net$", var.databricks_host))
    error_message = "Databricks host must be a valid Azure Databricks workspace URL."
  }
}

variable "databricks_token" {
  description = "Databricks Personal Access Token (PAT) for authentication"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.databricks_token) > 0
    error_message = "Databricks token cannot be empty."
  }
}

# -----------------------------------------------------------------------------
# Optional: Azure Backend Configuration
# -----------------------------------------------------------------------------
variable "resource_group_name" {
  description = "Azure resource group name for Terraform state storage"
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "Azure storage account name for Terraform state storage"
  type        = string
  default     = null
}

variable "container_name" {
  description = "Azure storage container name for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "key" {
  description = "Terraform state file key/name"
  type        = string
  default     = "databricks-setup.tfstate"
}

# -----------------------------------------------------------------------------
# Admin Groups Configuration
# -----------------------------------------------------------------------------
variable "admin_groups" {
  description = "List of admin group configurations with Azure AD integration"
  type = list(object({
    display_name          = string
    external_id           = optional(string)
    allow_cluster_create  = optional(bool, true)
    databricks_sql_access = optional(bool, true)
  }))

  validation {
    condition     = length(var.admin_groups) > 0
    error_message = "At least one admin group must be specified."
  }

  validation {
    condition     = alltrue([for g in var.admin_groups : length(g.display_name) > 0])
    error_message = "Admin group display names cannot be empty."
  }
}

# -----------------------------------------------------------------------------
# User Groups Configuration
# -----------------------------------------------------------------------------
variable "user_groups" {
  description = "List of user group configurations with Azure AD integration"
  type = list(object({
    display_name          = string
    external_id           = optional(string)
    roles                 = optional(list(string), ["user"])
    workspace_access      = optional(bool, true)
    allow_cluster_create  = optional(bool, false)
    databricks_sql_access = optional(bool, false)
  }))

  default = []

  validation {
    condition     = alltrue([for g in var.user_groups : length(g.display_name) > 0])
    error_message = "User group display names cannot be empty."
  }

  validation {
    condition = alltrue([
      for group in var.user_groups : alltrue([
        for role in group.roles : contains([
          "admin", "user", "account_admin", "cluster_admin", "workspace_admin",
          "token_admin", "notebook_admin", "sql_admin", "job_admin",
          "mlflow_admin", "feature_store_admin"
        ], role)
      ])
    ])
    error_message = "All roles must be valid Databricks roles."
  }
}

# -----------------------------------------------------------------------------
# Service Principals Configuration
# -----------------------------------------------------------------------------
variable "service_principals" {
  description = "List of Azure AD service principal configurations for Databricks access"
  type = list(object({
    application_id        = string
    display_name          = optional(string)
    roles                 = optional(list(string), ["user"])
    workspace_access      = optional(bool, true)
    allow_cluster_create  = optional(bool, false)
    databricks_sql_access = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for sp in var.service_principals : length(sp.application_id) > 0])
    error_message = "Service principal application_id cannot be empty."
  }

  validation {
    condition = alltrue([
      for sp in var.service_principals : alltrue([
        for role in sp.roles : contains([
          "admin", "user", "account_admin", "cluster_admin", "workspace_admin",
          "token_admin", "notebook_admin", "sql_admin", "job_admin",
          "mlflow_admin", "feature_store_admin"
        ], role)
      ])
    ])
    error_message = "All service principal roles must be valid Databricks roles."
  }

  default = []
}
variable "account_level_groups" {
  description = "List of account-level group configurations that will be available across all workspaces"
  type = list(object({
    display_name          = string
    external_id           = optional(string)
    roles                 = optional(list(string), ["user"])
    allow_cluster_create  = optional(bool, false)
    databricks_sql_access = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for g in var.account_level_groups : length(g.display_name) > 0])
    error_message = "Account level group display names cannot be empty."
  }

  validation {
    condition = alltrue([
      for group in var.account_level_groups : alltrue([
        for role in group.roles : contains([
          "admin", "user", "account_admin", "cluster_admin", "workspace_admin",
          "token_admin", "notebook_admin", "sql_admin", "job_admin",
          "mlflow_admin", "feature_store_admin"
        ], role)
      ])
    ])
    error_message = "All account level group roles must be valid Databricks roles."
  }

  default = []
}

variable "account_id" {
  description = "Databricks account ID for account-level operations"
  type        = string
  default     = null
}