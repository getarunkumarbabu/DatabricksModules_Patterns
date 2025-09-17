variable "view_name" {
  description = "Name of the SQL view"
  type        = string
}

variable "catalog_name" {
  description = "Name of the catalog where the view will be created"
  type        = string
}

variable "schema_name" {
  description = "Name of the schema where the view will be created"
  type        = string
}

variable "comment" {
  description = "Comment description for the view"
  type        = string
  default     = null
}

variable "query" {
  description = "SQL query that defines the view"
  type        = string
}

variable "cluster_id" {
  description = "ID of the cluster to use for view execution"
  type        = string
  default     = null
}

variable "is_temp" {
  description = "Whether to create a temporary view"
  type        = bool
  default     = false
}

variable "grants" {
  description = "Grants for the view"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = null
}
    privileges = list(string)
  }))
  default = null
}