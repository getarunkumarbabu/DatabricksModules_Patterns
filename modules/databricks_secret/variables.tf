variable "key" {
  description = "The key under which the secret value will be stored"
  type        = string
}

variable "string_value" {
  description = "The secret value to store"
  type        = string
  sensitive   = true
}

variable "scope" {
  description = "The name of the secret scope in which to store the secret"
  type        = string
}