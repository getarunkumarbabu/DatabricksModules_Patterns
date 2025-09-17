variable "path" {
  description = "The path where the notebook will be stored in the workspace"
  type        = string
}

variable "language" {
  description = "The language of the notebook (PYTHON, R, SCALA, SQL)"
  type        = string
  validation {
    condition     = contains(["PYTHON", "R", "SCALA", "SQL"], var.language)
    error_message = "Language must be one of: PYTHON, R, SCALA, SQL."
  }
}

variable "source" {
  description = "The source URL or path of the notebook"
  type        = string
}

variable "format" {
  description = "The format of the notebook (SOURCE, HTML, JUPYTER, DBC)"
  type        = string
  default     = "SOURCE"
  validation {
    condition     = contains(["SOURCE", "HTML", "JUPYTER", "DBC"], var.format)
    error_message = "Format must be one of: SOURCE, HTML, JUPYTER, DBC."
  }
}

variable "cluster_id" {
  description = "The ID of the cluster to attach the notebook to"
  type        = string
  default     = null
}