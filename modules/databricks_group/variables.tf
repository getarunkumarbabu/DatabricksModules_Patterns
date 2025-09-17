variable "display_name" {
  description = "Group display name"
  type        = string
}

variable "members" {
  description = "Optional list of member IDs to add to the group"
  type        = list(string)
  default     = null
}
