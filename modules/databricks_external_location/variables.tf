variable "name" {
  description = "The name of the external location in Unity Catalog. Must be unique within the metastore."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.name))
    error_message = "External location name can only contain alphanumeric characters and underscores."
  }
}

variable "url" {
  description = "The ABFS URL of the Azure storage location (e.g., abfss://container@account.dfs.core.windows.net/path)"
  type        = string

  validation {
    condition     = can(regex("^abfss://[^/]+@[^/]+\\.dfs\\.core\\.windows\\.net(/.*)?$", var.url))
    error_message = "URL must be a valid ABFS endpoint (e.g., abfss://container@account.dfs.core.windows.net/path)."
  }
}

variable "credential_name" {
  description = "The name of the Azure storage credential to use. Must be created using the databricks_storage_credential resource."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.credential_name))
    error_message = "Credential name can only contain alphanumeric characters and underscores."
  }
}

variable "comment" {
  description = "Description or comment about the external location. Use this to document purpose, data types, or usage patterns."
  type        = string
  default     = null
}

variable "owner" {
  description = "Username/group name/service principal application ID of the external location owner. Must be a valid Azure AD identity with appropriate permissions."
  type        = string
  default     = null
}

variable "read_only" {
  description = "Whether the external location is read-only. Set to true for data lakes that should be protected from writes."
  type        = bool
  default     = null
}

variable "skip_validation" {
  description = "Whether to skip validation of the external location URL and credential access. Not recommended for production."
  type        = bool
  default     = false
}