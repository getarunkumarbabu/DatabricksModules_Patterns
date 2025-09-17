variable "name" {
  description = "Name of the SQL query"
  type        = string
}

variable "warehouse_id" {
  description = "ID of the SQL warehouse to run the query"
  type        = string
}

variable "data_source_id" {
  description = "ID of the data source to use for the query"
  type        = string
}

variable "query" {
  description = "The SQL query text"
  type        = string
}

variable "run_as_role" {
  description = "Role to run the query as"
  type        = string
  default     = null
}

variable "parameters" {
  description = "List of query parameters"
  type = list(object({
    name  = string
    title = string
    type  = string
    value = string
  }))
  default = null
}

variable "schedule_enabled" {
  description = "Whether to enable scheduling for the query"
  type        = bool
  default     = false
}

variable "schedule_interval_seconds" {
  description = "How often to run the query (in seconds)"
  type        = number
  default     = null
}

variable "schedule_cron_expression" {
  description = "Cron expression for query scheduling"
  type        = string
  default     = null
}

variable "schedule_paused" {
  description = "Whether the schedule is paused"
  type        = bool
  default     = false
}

variable "query_options" {
  description = "Query execution options"
  type = object({
    cell_size = optional(string)
  })
  default = null
}