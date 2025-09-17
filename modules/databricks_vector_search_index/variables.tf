variable "index_name" {
  description = "Name of the vector search index"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the endpoint for the vector search index"
  type        = string
}

variable "primary_key" {
  description = "Primary key column name for the index"
  type        = string
}

variable "index_type" {
  description = "Type of the vector search index"
  type        = string
  default     = "APPROXIMATE_NEAREST_NEIGHBOR"
}

variable "source" {
  description = "Source configuration for the vector search index"
  type = object({
    table    = string
    filter   = optional(string)
    pipeline = optional(string)
  })
  default = null
}

variable "schema" {
  description = "Schema definition for the vector search index"
  type = map(object({
    type       = string
    dimension  = optional(number)
    is_primary = optional(bool)
    is_nullable = optional(bool)
  }))
}