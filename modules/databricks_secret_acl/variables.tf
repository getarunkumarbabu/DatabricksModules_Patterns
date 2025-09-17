variable "principal" {
  description = "The principal (user, service principal, or group) to grant permissions to"
  type        = string
}

variable "scope" {
  description = "The name of the secret scope"
  type        = string
}

variable "permission" {
  description = "The permission level to grant (READ or WRITE or MANAGE)"
  type        = string

  validation {
    condition     = contains(["READ", "WRITE", "MANAGE"], var.permission)
    error_message = "Permission must be one of: READ, WRITE, or MANAGE."
  }
}