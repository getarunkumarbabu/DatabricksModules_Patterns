variable "display_name" {
  description = "Display name of the service principal"
  type        = string
}

variable "allow_cluster_create" {
  description = "Allow service principal to create clusters"
  type        = bool
  default     = false
}

variable "allow_instance_pool_create" {
  description = "Allow service principal to create instance pools"
  type        = bool
  default     = false
}

variable "force" {
  description = "Force creation even if service principal exists"
  type        = bool
  default     = false
}

variable "active" {
  description = "Whether the service principal is active"
  type        = bool
  default     = true
}