variable "label" {
  description = "A label to organize a list of IP access lists. Consider using Azure resource naming conventions."
  type        = string

  validation {
    condition     = length(var.label) >= 3 && length(var.label) <= 30
    error_message = "Label must be between 3 and 30 characters long."
  }
}

variable "list_type" {
  description = "The type of IP access list. Valid values are: ALLOW (for allowed Azure VNET/IP ranges), BLOCK (for blocked IP ranges)."
  type        = string
  validation {
    condition     = contains(["ALLOW", "BLOCK"], var.list_type)
    error_message = "The list_type value must be either ALLOW or BLOCK."
  }
}

variable "ip_addresses" {
  description = "A list of IP addresses/CIDR ranges to be added to the IP access list. For Azure VNETs, use the VNET's CIDR range."
  type        = list(string)

  validation {
    condition = length(var.ip_addresses) > 0
    error_message = "At least one IP address/CIDR range must be provided."
  }
}

variable "enabled" {
  description = "Whether this IP access list is enabled. Use this to temporarily disable access without removing the configuration."
  type        = bool
  default     = true
}