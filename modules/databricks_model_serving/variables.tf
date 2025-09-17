variable "name" {
  description = "The name of the model serving endpoint"
  type        = string
}

variable "model_name" {
  description = "The name of the MLflow model to serve"
  type        = string
}

variable "model_version" {
  description = "The version of the MLflow model to serve"
  type        = string
}

variable "workload_size" {
  description = "The workload size for the serving endpoint (Small, Medium, Large)"
  type        = string
  default     = "Small"
  validation {
    condition     = contains(["Small", "Medium", "Large"], var.workload_size)
    error_message = "Workload size must be one of: Small, Medium, Large."
  }
}

variable "scale_to_zero_enabled" {
  description = "Whether to enable scale-to-zero functionality"
  type        = bool
  default     = true
}