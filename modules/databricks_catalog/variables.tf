variable "name" {
  description = "The name of the catalog. Must be unique within the workspace. May only contain alphanumeric characters, underscores, and dots."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.]+$", var.name))
    error_message = "The catalog name can only contain alphanumeric characters, underscores, and dots."
  }
}

variable "comment" {
  description = "Description or comment about the catalog. Use this to document the purpose and contents of the catalog."
  type        = string
  default     = null
}

variable "properties" {
  description = "Key-value pairs to associate with the catalog. Common properties include environment, department, team, costCenter, purpose."
  type        = map(string)
  default     = {}
}

variable "owner" {
  description = "Username/group name/service principal application ID of the catalog owner. Must be a valid user, service principal, or group in the workspace."
  type        = string
  default     = null
}

variable "force_delete" {
  description = "Delete the catalog regardless of its contents. If false, attempting to delete a non-empty catalog will result in an error."
  type        = bool
  default     = false
}

variable "isolation_mode" {
  description = "Catalog isolation level. Can be OPEN or ISOLATED. In ISOLATED mode, only users explicitly granted access can access the catalog."
  type        = string
  default     = "OPEN"

  validation {
    condition     = contains(["OPEN", "ISOLATED"], var.isolation_mode)
    error_message = "Isolation mode must be either OPEN or ISOLATED."
  }
}

variable "provider_name" {
  description = "Name of the storage provider for external catalogs. Must be 'azure' for Azure storage integration."
  type        = string
  default     = null

  validation {
    condition     = var.provider_name == null || var.provider_name == "azure"
    error_message = "Provider name must be 'azure' for Azure storage integration."
  }
}

variable "storage_root" {
  description = "Storage root URL for external catalogs. Required if provider_name is set. Must be an Azure storage account URL in the format 'abfss://container@account.dfs.core.windows.net/path'."
  type        = string
  default     = null

  validation {
    condition     = var.storage_root == null || can(regex("^abfss://[^/]+@[^/]+\\.dfs\\.core\\.windows\\.net/", var.storage_root))
    error_message = "Storage root must be a valid Azure ABFS URL in the format 'abfss://container@account.dfs.core.windows.net/path'."
  }
}

variable "tags" {
  description = "Tags to attach to the catalog for organization and governance."
  type        = map(string)
  default     = {}
}