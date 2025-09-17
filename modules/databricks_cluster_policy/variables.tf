variable "name" {
  description = "Name of the cluster policy"
  type        = string
}

variable "definition" {
  description = "Policy definition JSON string or map"
  type        = any
}

variable "policy_family_id" {
  description = "Optional policy family ID to extend"
  type        = string
  default     = null
}

variable "policy_family_overrides" {
  description = "Overrides when using a policy family"
  type        = map(any)
  default     = {}
}