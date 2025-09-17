variable "name" {
  description = "Name of the vector search index"
  type        = string
}

variable "catalog" {
  description = "Name of the catalog containing the source table"
  type        = string
}

variable "schema" {
  description = "Name of the schema containing the source table"
  type        = string
}

variable "table_name" {
  description = "Name of the source table"
  type        = string
}

variable "primary_key" {
  description = "Primary key column in the source table"
  type        = string
}

variable "embedding_size" {
  description = "Size of the embedding vectors"
  type        = number
}

variable "field_mappings" {
  description = "Field mappings for the vector search index"
  type = object({
    field_name = string
    source     = string
  })
}

variable "endpoint_name" {
  description = "Name of the endpoint to use for vector search"
  type        = string
  default     = null
}