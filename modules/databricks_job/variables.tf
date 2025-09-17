variable "name" {
  description = "Name of the job"
  type        = string
}

variable "spark_version" {
  description = "Spark runtime version for the job cluster"
  type        = string
  default     = "12.0.x-scala2.12"
}

variable "node_type_id" {
  description = "Node type for job cluster"
  type        = string
}

variable "autotermination_minutes" {
  description = "Autotermination minutes for the job cluster"
  type        = number
  default     = 60
}

variable "notebook_path" {
  description = "Workspace path to the notebook to run"
  type        = string
}

variable "max_retries" {
  description = "Max retries for job run"
  type        = number
  default     = 0
}

variable "spark_conf" {
  description = "Optional spark configuration map for the job cluster"
  type        = map(string)
  default     = {}
}
