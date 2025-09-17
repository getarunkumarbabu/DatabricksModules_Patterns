variable "path" {
  description = "Path to the notebook in the workspace"
  type        = string
}

variable "language" {
  description = "Language of the notebook (SCALA, PYTHON, SQL, or R)"
  type        = string
  validation {
    condition     = contains(["SCALA", "PYTHON", "SQL", "R"], var.language)
    error_message = "Language must be one of: SCALA, PYTHON, SQL, R."
  }
}

variable "source" {
  description = "Source path in the local filesystem or URL"
  type        = string
  default     = null
}

variable "format" {
  description = "Format of the notebook (SOURCE, HTML, JUPYTER, DBC)"
  type        = string
  default     = "SOURCE"
  validation {
    condition     = contains(["SOURCE", "HTML", "JUPYTER", "DBC"], var.format)
    error_message = "Format must be one of: SOURCE, HTML, JUPYTER, DBC."
  }
}

variable "content_base64" {
  description = "Base64 encoded content of the notebook"
  type        = string
  default     = null
}

variable "cluster" {
  description = "Cluster configuration for the notebook"
  type = object({
    num_workers = optional(number)
    cluster_id  = optional(string)
  })
  default = null
}