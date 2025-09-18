variable "name" {
  description = "Name of the share"
  type        = string
}

variable "comment" {
  description = "Comment describing the share"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner of the share"
  type        = string
  default     = null
}

variable "data_object_permissions" {
  description = "List of data object permissions"
  type = list(object({
    data_object_type = string
    name             = string
    privilege        = string
  }))
  default = null
}

variable "recipients" {
  description = "List of share recipients"
  type = list(object({
    name                               = string
    allowed_ip_addresses               = optional(list(string))
    comment                            = optional(string)
    data_recipient_global_metastore_id = optional(string)
    sharing_code                       = optional(string)
  }))
  default = null
}