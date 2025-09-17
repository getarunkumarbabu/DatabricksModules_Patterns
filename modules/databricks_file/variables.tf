variable "path" {
  description = "Workspace path where the file will be stored"
  type        = string
}

variable "source_path" {
  description = "Local path to the source file"
  type        = string
  default     = null
}

variable "content_base64" {
  description = "Base64-encoded content of the file"
  type        = string
  default     = null
}

variable "md5" {
  description = "MD5 hash of the file content"
  type        = string
  default     = null
}