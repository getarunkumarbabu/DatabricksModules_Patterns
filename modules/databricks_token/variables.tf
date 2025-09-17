variable "comment" {
  description = "Comment describing the purpose of the token"
  type        = string
}

variable "lifetime_seconds" {
  description = "Lifetime of the token in seconds. If not specified, token never expires"
  type        = number
  default     = null
}