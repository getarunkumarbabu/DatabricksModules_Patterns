variable "name" {
  description = "Name of the volume"
  type        = string
}

variable "catalog_name" {
  description = "Name of the catalog where volume will be created"
  type        = string
}

variable "schema_name" {
  description = "Name of the schema where volume will be created"
  type        = string
}

variable "volume_type" {
  description = "Type of the volume (EXTERNAL or MANAGED)"
  type        = string
  default     = "MANAGED"
  validation {
    condition     = contains(["MANAGED", "EXTERNAL"], var.volume_type)
    error_message = "volume_type must be either MANAGED or EXTERNAL."
  }
}

variable "storage_location" {
  description = "Storage location for the volume"
  type        = string
  default     = null
}

variable "comment" {
  description = "Comment describing the volume"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner of the volume"
  type        = string
  default     = null
}

variable "azure_storage_container" {
  description = "Azure Storage container configuration"
  type = object({
    container_name       = string
    storage_account_name = string
    path                = string
  })
  default = null
}