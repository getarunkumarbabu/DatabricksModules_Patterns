variable "cluster_name" {
  description = "Name of the Databricks cluster"
  type        = string
}

variable "spark_version" {
  description = "Spark runtime version"
  type        = string
}

variable "node_type_id" {
  description = "Node type id for worker/driver"
  type        = string
}

variable "autotermination_minutes" {
  description = "Minutes until auto-termination (idle)"
  type        = number
  default     = 60
}

variable "autoscale_min_workers" {
  description = "Autoscale min workers"
  type        = number
  default     = 1
}

variable "autoscale_max_workers" {
  description = "Autoscale max workers"
  type        = number
  default     = 2
}

variable "spark_conf" {
  description = "Map of spark configurations"
  type        = map(string)
  default     = {}
}

variable "enable_elastic_disk" {
  description = "Enable elastic disk"
  type        = bool
  default     = false
}

variable "custom_tags" {
  description = "Optional map of custom tags"
  type        = map(string)
  default     = null
}
