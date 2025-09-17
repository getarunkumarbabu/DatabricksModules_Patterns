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

variable "delta_sync_index_spec" {
  description = "Delta sync index specification"
  type = object({
    full_sync_frequency = optional(string)
    continuous         = optional(bool)
  })
  default = null
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

variable "index_config" {
  description = "Configuration for the vector search index"
  type = object({
    embedding_source_columns  = optional(list(string))
    embedding_model_endpoint  = optional(string)
    embedding_vector_column  = optional(string)
    embedding_dimension      = optional(number)
    metric_type             = optional(string)
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