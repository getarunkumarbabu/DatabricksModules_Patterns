variable "principal" {
  description = "The name of the principal (user, service principal, or group) to grant privileges to"
  type        = string
}

variable "privileges" {
  description = "List of privileges to grant"
  type        = list(string)
}

# Catalog grant variables
variable "catalog_name" {
  description = "Name of the catalog to grant privileges on"
  type        = string
  default     = null
}

# Schema grant variables
variable "schema_name" {
  description = "Name of the schema to grant privileges on"
  type        = string
  default     = null
}

variable "schema_catalog_name" {
  description = "Name of the catalog containing the schema"
  type        = string
  default     = null
}

# Table grant variables
variable "table_name" {
  description = "Name of the table to grant privileges on"
  type        = string
  default     = null
}

variable "table_schema_name" {
  description = "Name of the schema containing the table"
  type        = string
  default     = null
}

variable "table_catalog_name" {
  description = "Name of the catalog containing the table"
  type        = string
  default     = null
}

# Volume grant variables
variable "volume_name" {
  description = "Name of the volume to grant privileges on"
  type        = string
  default     = null
}

variable "volume_schema_name" {
  description = "Name of the schema containing the volume"
  type        = string
  default     = null
}

variable "volume_catalog_name" {
  description = "Name of the catalog containing the volume"
  type        = string
  default     = null
}