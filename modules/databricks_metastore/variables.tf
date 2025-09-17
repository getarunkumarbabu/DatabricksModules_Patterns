variable "name" {
  description = "The name of the metastore"
  type        = string
}

variable "storage_root" {
  description = "The storage root URL for the metastore (e.g., s3://, abfss://, gs://)"
  type        = string
}

variable "region" {
  description = "The region where the metastore should be created"
  type        = string
}

variable "owner" {
  description = "Username/group name/service principal application ID of the metastore owner"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Whether to force destroy the metastore even if it contains data"
  type        = bool
  default     = false
}