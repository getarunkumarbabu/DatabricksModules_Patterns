variable "custom_config" {
  description = "Map of workspace configurations to set"
  type        = map(string)
}

variable "enable_serverless_compute" {
  description = "Whether to enable serverless compute"
  type        = bool
  default     = false
}