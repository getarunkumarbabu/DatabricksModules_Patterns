variable "path" {
  description = "The path in DBFS where the file should be stored"
  type        = string
}

variable "source" {
  description = "The local path to the file to upload"
  type        = string
  default     = null
}

variable "content" {
  description = "The direct content to be stored in the file"
  type        = string
  default     = null
}

variable "content_b64" {
  description = "The base64-encoded content to be stored in the file"
  type        = string
  default     = null
}

variable "overwrite" {
  description = "Whether to overwrite an existing file"
  type        = bool
  default     = false
}

variable "md5" {
  description = "The MD5 hash of the file content for validation"
  type        = string
  default     = null
}