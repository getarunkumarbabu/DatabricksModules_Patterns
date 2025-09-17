variable "name" {
  description = "Name of the connection"
  type        = string
}

variable "connection_type" {
  description = "Type of the connection (e.g., MYSQL, POSTGRESQL, SNOWFLAKE, etc.)"
  type        = string
  validation {
    condition     = contains(["MYSQL", "POSTGRESQL", "SNOWFLAKE", "REDSHIFT", "SQLSERVER", "SYNAPSE", "BIGQUERY"], var.connection_type)
    error_message = "connection_type must be one of: MYSQL, POSTGRESQL, SNOWFLAKE, REDSHIFT, SQLSERVER, SYNAPSE, BIGQUERY."
  }
}

variable "comment" {
  description = "Comment describing the connection"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner of the connection"
  type        = string
  default     = null
}

variable "properties" {
  description = "Additional connection properties"
  type        = map(string)
  default     = null
}

variable "options" {
  description = "Connection options"
  type = object({
    host                     = optional(string)
    port                     = optional(number)
    database                 = optional(string)
    user                     = optional(string)
    password                 = optional(string)
    encrypt                  = optional(bool)
    trust_server_certificate = optional(bool)
    authentication           = optional(string)
    role                     = optional(string)
    warehouse               = optional(string)
  })
  default   = null
  sensitive = true
}