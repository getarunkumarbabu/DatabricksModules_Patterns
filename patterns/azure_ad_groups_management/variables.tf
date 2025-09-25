# Variables for Simple Azure AD Groups Management

# Admin Groups - Map of Azure AD groups to add as admins
variable "admin_groups" {
  description = "Map of Azure AD groups to add with admin role (name -> external_id)"
  type = map(object({
    display_name = string
    external_id  = string
  }))
  default = {}
}

# User Groups - Map of Azure AD groups to add as users
variable "user_groups" {
  description = "Map of Azure AD groups to add with user role (name -> external_id)"
  type = map(object({
    display_name = string
    external_id  = string
  }))
  default = {}
}

# =============================================================================
# Databricks Authentication Variables (Optional - use environment variables instead)
# =============================================================================

variable "databricks_host" {
  description = "Databricks workspace URL (e.g., https://your-workspace.cloud.databricks.com/)"
  type        = string
  default     = null
  sensitive   = false
}

variable "databricks_token" {
  description = "Databricks personal access token"
  type        = string
  default     = null
  sensitive   = true
}

# Azure-specific authentication variables
variable "azure_workspace_resource_id" {
  description = "Azure resource ID of the Databricks workspace"
  type        = string
  default     = null
  sensitive   = false
}

variable "azure_tenant_id" {
  description = "Azure Active Directory tenant ID"
  type        = string
  default     = null
  sensitive   = false
}

variable "azure_client_id" {
  description = "Azure service principal client ID"
  type        = string
  default     = null
  sensitive   = false
}

variable "azure_client_secret" {
  description = "Azure service principal client secret"
  type        = string
  default     = null
  sensitive   = true
}

variable "databricks_account_id" {
  description = "Databricks account ID (required for account-level SCIM groups)"
  type        = string
  default     = null
  sensitive   = false
}