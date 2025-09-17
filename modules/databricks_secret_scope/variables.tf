variable "name" {
  description = "Name of the secret scope"
  type        = string
}

variable "initial_manage_principal" {
  description = "Initial manage principal for the scope (e.g., users)"
  type        = string
  default     = "users"
}

variable "secrets_map" {
  description = "Optional map of secrets to create (key -> value)"
  type        = map(string)
  default     = null
}
