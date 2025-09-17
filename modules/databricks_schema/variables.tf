variable "catalog_name" {
  description = "The name of the catalog containing the schema"
  type        = string
}

variable "name" {
  description = "The name of the schema"
  type        = string
}

variable "comment" {
  description = "Description or comment about the schema"
  type        = string
  default     = null
}

variable "properties" {
  description = "Map of schema properties"
  type        = map(string)
  default     = {}
}

variable "owner" {
  description = "Username/group name/service principal application ID of the schema owner"
  type        = string
  default     = null
}