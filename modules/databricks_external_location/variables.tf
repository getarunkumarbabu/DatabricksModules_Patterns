variable "name" {
  description = "The name of the external location"
  type        = string
}

variable "url" {
  description = "The URL of the external location (e.g., s3://, abfss://, gs://)"
  type        = string
}

variable "credential_name" {
  description = "The name of the storage credential to use for this external location"
  type        = string
}

variable "comment" {
  description = "Description or comment about the external location"
  type        = string
  default     = null
}

variable "owner" {
  description = "Username/group name/service principal application ID of the external location owner"
  type        = string
  default     = null
}

variable "read_only" {
  description = "Whether the external location is read-only"
  type        = bool
  default     = null
}