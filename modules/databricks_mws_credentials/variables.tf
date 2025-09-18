variable "account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "credentials_name" {
  description = "Name for the credentials"
  type        = string
}

variable "application_id" {
  description = "Azure service principal application ID"
  type        = string
}

variable "client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
}

variable "directory_id" {
  description = "Azure directory (tenant) ID"
  type        = string
}