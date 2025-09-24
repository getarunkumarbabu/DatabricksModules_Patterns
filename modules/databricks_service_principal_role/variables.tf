variable "application_id" {
  description = "Azure AD application ID for the service principal"
  type        = string
}

variable "display_name" {
  description = "Display name for the service principal"
  type        = string
}

variable "roles" {
  description = "List of roles to assign to the service principal"
  type        = list(string)
  default     = []
}