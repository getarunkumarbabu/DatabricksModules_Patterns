variable "user_name" {
  description = "User name (email)"
  type        = string
}

variable "display_name" {
  description = "Display name for the user"
  type        = string
}

variable "active" {
  description = "Whether the user is active"
  type        = bool
  default     = true
}

variable "force" {
  description = "Force creation even if user exists"
  type        = bool
  default     = false
}