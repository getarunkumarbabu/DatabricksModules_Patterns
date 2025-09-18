variable "name" {
  description = "Name of the table"
  type        = string
}

variable "catalog_name" {
  description = "Name of the catalog where table will be created"
  type        = string
}

variable "schema_name" {
  description = "Name of the schema where table will be created"
  type        = string
}

variable "table_type" {
  description = "Type of the table (MANAGED or EXTERNAL)"
  type        = string
  default     = "MANAGED"
  validation {
    condition     = contains(["MANAGED", "EXTERNAL"], var.table_type)
    error_message = "table_type must be either MANAGED or EXTERNAL."
  }
}

variable "data_source_format" {
  description = "Data source format for the table"
  type        = string
  default     = "DELTA"
}

variable "comment" {
  description = "Comment describing the table"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner of the table"
  type        = string
  default     = null
}

variable "columns" {
  description = "List of columns in the table"
  type = list(object({
    name      = string
    type_name = string
    type_text = string
    position  = number
    comment   = optional(string)
    nullable  = optional(bool, true)
  }))
}

variable "storage_location" {
  description = "Storage location for external tables"
  type        = string
  default     = null
}

variable "partition_columns" {
  description = "List of column names to partition by"
  type        = list(string)
  default     = null
}

variable "cluster_keys" {
  description = "List of column names to cluster by"
  type        = list(string)
  default     = null
}

variable "properties" {
  description = "Properties of the table"
  type        = map(string)
  default     = {}
}

variable "tblproperties" {
  description = "Additional table properties"
  type        = map(string)
  default     = null
}