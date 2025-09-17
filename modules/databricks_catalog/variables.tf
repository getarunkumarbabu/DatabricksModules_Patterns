variable "name" {
  description = "The name of the catalog"
  type        = string
}

variable "comment" {
  description = "Description or comment about the catalog"
  type        = string
  default     = null
}

variable "properties" {
  description = "Map of catalog properties"
  type        = map(string)
  default     = {}
}

variable "owner" {
  description = "Username/group name/service principal application ID of the catalog owner"
  type        = string
  default     = null
}