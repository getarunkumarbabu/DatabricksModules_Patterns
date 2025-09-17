variable "display_name" {
  description = "Display name of the service principal in Azure Databricks"
  type        = string
}

variable "application_id" {
  description = "Application (client) ID from Azure AD for the service principal"
  type        = string
  default     = null

  validation {
    condition     = var.application_id == null || can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.application_id))
    error_message = "The application_id must be a valid Azure AD Application ID (GUID format)."
  }
}

variable "aad_object_id" {
  description = "Azure AD Object ID of the service principal for synchronization"
  type        = string
  default     = null

  validation {
    condition     = var.aad_object_id == null || can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.aad_object_id))
    error_message = "The aad_object_id must be a valid Azure AD Object ID (GUID format)."
  }
}

variable "allow_cluster_create" {
  description = "Allow service principal to create Azure Databricks clusters"
  type        = bool
  default     = false
}

variable "allow_instance_pool_create" {
  description = "Allow service principal to create Azure Databricks instance pools"
  type        = bool
  default     = false
}

variable "force" {
  description = "Force creation even if service principal exists in Azure Databricks"
  type        = bool
  default     = false
}

variable "active" {
  description = "Whether the service principal is active in Azure Databricks"
  type        = bool
  default     = true
}