variable "name" {
  description = "The name of the mount"
  type        = string
}

variable "uri" {
  description = "The URI to mount (e.g., s3://bucket-name/path)"
  type        = string
}

variable "s3_config" {
  description = "Configuration for S3 mount"
  type = object({
    bucket_name      = string
    instance_profile = optional(string)
    role_arn        = optional(string)
  })
  default = null
}

variable "azure_config" {
  description = "Configuration for Azure Storage mount"
  type = object({
    container_name       = string
    storage_account_name = string
    directory           = optional(string)
    auth_type           = string
    tenant_id           = optional(string)
    client_id           = optional(string)
    client_secret       = optional(string)
  })
  default = null
}

variable "gcp_config" {
  description = "Configuration for Google Cloud Storage mount"
  type = object({
    bucket_name     = string
    service_account = string
  })
  default = null
}

variable "extra_config" {
  description = "Additional configuration options for the mount"
  type        = map(string)
  default     = {}
}