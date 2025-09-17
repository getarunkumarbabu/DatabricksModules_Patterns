variable "name" {
  description = "The name of the MLflow experiment"
  type        = string
}

variable "description" {
  description = "Description of the MLflow experiment"
  type        = string
  default     = null
}

variable "artifact_location" {
  description = "The location to store run artifacts. If not provided, Databricks will create a directory in the workspace's root artifact location"
  type        = string
  default     = null
}