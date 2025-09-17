variable "name" {
  description = "Name of the MLflow experiment"
  type        = string
}

variable "artifact_location" {
  description = "Location where artifacts for runs are stored"
  type        = string
  default     = null
}