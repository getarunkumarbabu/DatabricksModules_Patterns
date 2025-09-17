variable "name" {
  description = "Name of the SQL dashboard"
  type        = string
}

variable "tags" {
  description = "Tags to categorize and organize the dashboard"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description of the dashboard's purpose"
  type        = string
  default     = null
}

variable "warehouse_id" {
  description = "ID of the SQL warehouse to use for this dashboard"
  type        = string
}

variable "parent" {
  description = "Parent folder ID for organizing the dashboard"
  type        = string
  default     = null
}