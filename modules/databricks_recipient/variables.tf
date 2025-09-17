variable "name" {
  description = "Name of the recipient"
  type        = string
}

variable "authentication_type" {
  description = "Authentication type for the recipient (TOKEN or IP)"
  type        = string
  validation {
    condition     = contains(["TOKEN", "IP"], var.authentication_type)
    error_message = "Authentication type must be either TOKEN or IP."
  }
}

variable "comment" {
  description = "Comment describing the recipient"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner of the recipient"
  type        = string
  default     = null
}

variable "allowed_ip_addresses" {
  description = "List of IP addresses or CIDR blocks allowed to access the share"
  type        = list(string)
  default     = null
}

variable "sharing_code" {
  description = "Optional sharing code for the recipient"
  type        = string
  default     = null
  sensitive   = true
}