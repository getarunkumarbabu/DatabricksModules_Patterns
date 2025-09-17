variable "name" {
  description = "Name of the init script"
  type        = string
}

variable "content" {
  description = "Content of the init script"
  type        = string
}

variable "enabled" {
  description = "Whether the init script is enabled"
  type        = bool
  default     = true
}

variable "position" {
  description = "Position of the init script (determines execution order)"
  type        = number
  default     = null
}