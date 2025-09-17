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

variable "aws_iam_role" {
  description = "AWS IAM role configuration"
  type = object({
    role_arn = string
  })
  default = null
}

variable "azure_managed_identity" {
  description = "Azure managed identity configuration"
  type = object({
    access_connector_id = string
  })
  default = null
}

variable "azure_service_principal" {
  description = "Azure service principal configuration"
  type = object({
    directory_id   = string
    application_id = string
    client_secret  = string
  })
  default = null
}

variable "databricks_gcp_service_account" {
  description = "GCP service account configuration"
  type = object({
    email = string
  })
  default = null
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