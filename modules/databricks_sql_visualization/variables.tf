variable "query_id" {
  description = "ID of the query to which this visualization belongs"
  type        = string
}

variable "name" {
  description = "Name of the visualization"
  type        = string
}

variable "description" {
  description = "Description of the visualization"
  type        = string
  default     = null
}

variable "options" {
  description = "Visualization options as a map"
  type        = map(any)
  default     = {}
}