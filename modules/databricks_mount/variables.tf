variable "name" {
  description = "The name of the mount point in DBFS."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.name))
    error_message = "Mount name can only contain alphanumeric characters, underscores, and hyphens."
  }
}

variable "container_name" {
  description = "The name of the Azure Storage container to mount."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Azure Storage account."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 24 characters long and can only contain lowercase letters and numbers."
  }
}

variable "directory" {
  description = "Optional directory within the container to mount. Leave empty to mount the entire container."
  type        = string
  default     = ""
}

variable "auth_type" {
  description = "Authentication type for Azure Storage. Must be either 'SERVICE_PRINCIPAL' or 'MANAGED_IDENTITY'."
  type        = string
  default     = "SERVICE_PRINCIPAL"

  validation {
    condition     = contains(["SERVICE_PRINCIPAL", "MANAGED_IDENTITY"], var.auth_type)
    error_message = "Auth type must be either SERVICE_PRINCIPAL or MANAGED_IDENTITY."
  }
}

variable "tenant_id" {
  description = "Azure AD tenant ID. Required when auth_type is SERVICE_PRINCIPAL."
  type        = string
  default     = null
}

variable "client_id" {
  description = "Azure AD client (application) ID. Required when auth_type is SERVICE_PRINCIPAL."
  type        = string
  default     = null
}

variable "client_secret" {
  description = "Azure AD client secret. Required when auth_type is SERVICE_PRINCIPAL."
  type        = string
  default     = null
  sensitive   = true
}

variable "uri" {
  description = "The ABFS URI for the Azure Storage mount point (e.g., abfss://container@storageaccount.dfs.core.windows.net/path)."
  type        = string

  validation {
    condition     = can(regex("^abfss://[^/]+@[^/]+\\.dfs\\.core\\.windows\\.net(/.*)?$", var.uri))
    error_message = "URI must be a valid ABFS endpoint (e.g., abfss://container@storageaccount.dfs.core.windows.net/path)."
  }
}

variable "extra_config" {
  description = "Additional configuration options for the mount. Common options include connection timeouts, retry policies, etc."
  type        = map(string)
  default     = {}
}