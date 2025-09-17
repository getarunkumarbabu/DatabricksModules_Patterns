variable "name" {
  description = "Name of the SQL query"
  type        = string
}

variable "data_source_id" {
  description = "ID of the data source"
  type        = string
}

variable "query" {
  description = "SQL query text"
  type        = string
}

variable "schedule_interval_seconds" {
  description = "Interval in seconds between query runs"
  type        = number
  default     = null
}

variable "schedule_timezone" {
  description = "Timezone for the schedule"
  type        = string
  default     = "UTC"
}

variable "schedule_paused" {
  description = "Whether the schedule is paused"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the query"
  type        = map(string)
  default     = {}
}