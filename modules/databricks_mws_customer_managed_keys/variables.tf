variable "account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "access_connector_id" {
  description = "Azure managed identity access connector ID"
  type        = string
}

variable "credential_id" {
  description = "Azure managed identity credential ID"
  type        = string
}

variable "use_cases" {
  description = "List of use cases for customer managed keys"
  type        = list(string)
}

variable "key_info" {
  description = "Azure Key Vault key information"
  type = object({
    key_vault_uri = string
    key_name      = string
    key_version   = optional(string)
  })
  default = null
}