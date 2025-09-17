variable "name" {
  description = "Name of the MLflow model"
  type        = string
}

variable "description" {
  description = "Description of the MLflow model"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to be applied to the MLflow model"
  type        = list(string)
  default     = []
}