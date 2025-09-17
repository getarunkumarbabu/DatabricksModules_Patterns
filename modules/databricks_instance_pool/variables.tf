variable "name" {
  description = "Instance pool name"
  type        = string
}

variable "min_idle_instances" {
  description = "Minimum idle instances"
  type        = number
  default     = 0
}

variable "max_capacity" {
  description = "Maximum capacity"
  type        = number
}

variable "node_type_id" {
  description = "Node type id"
  type        = string
}

variable "idle_instance_autotermination_minutes" {
  description = "Idle instance autotermination minutes"
  type        = number
  default     = 60
}

variable "aws_availability" {
  description = "AWS availability (e.g., SPOT)"
  type        = string
  default     = "ON_DEMAND"
}
