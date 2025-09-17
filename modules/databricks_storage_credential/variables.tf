variable "name" {
  description = "Name of storage credential"
  type        = string
}

variable "comment" {
  description = "Comment describing the credential"
  type        = string
  default     = null
}

variable "owner" {
  description = "Username/GroupName/ServicePrincipal of the credential owner"
  type        = string
  default     = null
}

variable "azure_managed_identity" {
  description = "Azure managed identity configuration for accessing Azure storage. Requires Azure Databricks Premium tier."
  type = object({
    access_connector_id = string # Resource ID of the Azure Databricks access connector
  })
  default = null

  validation {
    condition = var.azure_managed_identity == null || can(regex("^/subscriptions/[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}/resourceGroups/[^/]+/providers/Microsoft.Databricks/accessConnectors/[^/]+$", var.azure_managed_identity.access_connector_id))
    error_message = "The access_connector_id must be a valid Azure resource ID for a Databricks access connector."
  }
}

variable "azure_service_principal" {
  description = "Azure service principal configuration for accessing Azure storage"
  type = object({
    directory_id   = string # Azure AD tenant ID
    application_id = string # Azure AD application ID
    client_secret  = string # Azure AD client secret
  })
  default = null

  validation {
    condition = var.azure_service_principal == null || (
      can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.azure_service_principal.directory_id)) &&
      can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.azure_service_principal.application_id))
    )
    error_message = "The directory_id and application_id must be valid Azure GUID/UUID values."
  }
}

variable "force_destroy" {
  description = "Delete credential regardless of dependencies"
  type        = bool
  default     = false
}

variable "force_update" {
  description = "Force update even if credential is used by external locations"
  type        = bool
  default     = false
}