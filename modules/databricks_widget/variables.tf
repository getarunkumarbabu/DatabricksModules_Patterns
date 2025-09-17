variable "query_id" {
  description = "ID of the SQL query associated with this widget"
  type        = string
}

variable "dashboard_id" {
  description = "ID of the dashboard containing this widget"
  type        = string
}

variable "visualization_id" {
  description = "ID of the visualization for this widget"
  type        = string
}

variable "title" {
  description = "Title of the widget"
  type        = string
}

variable "type" {
  description = "Type of the widget"
  type        = string
}

variable "width" {
  description = "Width of the widget"
  type        = number
  default     = 3
}

variable "options" {
  description = "Configuration options for the widget"
  type        = any
  default     = {}
}

variable "parameter_mappings" {
  description = "Parameter mappings for the widget"
  type = object({
    name    = string
    type    = string
    map_to  = string
    default = optional(string)
    title   = optional(string)
    value   = optional(string)
    global  = optional(bool)
  })
  default = null
}