variable "label" {
  description = "A label to organize a list of IP access lists."
  type        = string
}

variable "list_type" {
  description = "The type of IP access list. Valid values are: ALLOW, BLOCK."
  type        = string
  validation {
    condition     = contains(["ALLOW", "BLOCK"], var.list_type)
    error_message = "The list_type value must be either ALLOW or BLOCK."
  }
}

variable "ip_addresses" {
  description = "A list of IP addresses/CIDR ranges to be added to the IP access list."
  type        = list(string)
}

variable "enabled" {
  description = "Whether this IP access list is enabled."
  type        = bool
  default     = true
}