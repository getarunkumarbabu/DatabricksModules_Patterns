variable "name" {
  description = "Name of the view"
  type        = string
}

variable "catalog" {
  description = "Name of the catalog"
  type        = string
}

variable "schema" {
  description = "Name of the schema"
  type        = string
}

variable "sql" {
  description = "SQL query defining the view"
  type        = string
}

variable "comment" {
  description = "Comment for the view"
  type        = string
  default     = null
}

variable "cluster_id" {
  description = "ID of the cluster to run the view query on"
  type        = string
  default     = null
}

variable "is_temp" {
  description = "Whether the view is temporary"
  type        = bool
  default     = false
}

variable "permissions" {
  description = "Permissions configuration for the view"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = null
}