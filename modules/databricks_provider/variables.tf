variable "azure_workspace_resource_id" {
  description = "The Azure resource ID for the Databricks workspace"
  type        = string
  default     = null
}

variable "host" {
  description = "The Databricks host URL"
  type        = string
  default     = null
}

variable "token" {
  description = "The Databricks personal access token"
  type        = string
  default     = null
  sensitive   = true
}

variable "azure_client_id" {
  description = "Azure client ID for service principal"
  type        = string
  default     = null
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure client secret for service principal"
  type        = string
  default     = null
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID for service principal"
  type        = string
  default     = null
}

variable "auth" {
  description = "Authentication configuration block"
  type = object({
    azure_client_id     = string
    azure_client_secret = string
    azure_tenant_id     = string
  })
  default   = null
  sensitive = true
}