variable "name" {
  description = "Name of the model serving endpoint"
  type        = string
}

variable "model_name" {
  description = "Name of the model to serve"
  type        = string
}

variable "model_version" {
  description = "Version of the model to serve"
  type        = string
}

variable "workload_size" {
  description = "Size of the workload (Small, Medium, Large)"
  type        = string
  default     = "Small"
  validation {
    condition     = contains(["Small", "Medium", "Large"], var.workload_size)
    error_message = "Workload size must be one of: Small, Medium, Large."
  }
}

variable "scale_to_zero_enabled" {
  description = "Whether to enable scale-to-zero"
  type        = bool
  default     = true
}