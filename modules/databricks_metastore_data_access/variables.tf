variable "metastore_id" {
  description = "ID of the metastore to configure data access for"
  type        = string
}

variable "name" {
  description = "Name of the data access configuration"
  type        = string
}

variable "owner" {
  description = "Owner of the data access configuration"
  type        = string
}

variable "access_connector_id" {
  description = "Azure access connector ID for managed identity"
  type        = string
}

variable "is_default" {
  description = "Whether this is the default data access configuration"
  type        = bool
  default     = false
}

variable "comment" {
  description = "Comment for the data access configuration"
  type        = string
  default     = null
}