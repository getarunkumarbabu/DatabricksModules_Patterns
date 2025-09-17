variable "name" {
  description = "Name of the SQL warehouse"
  type        = string
}

variable "cluster_size" {
  description = "Size of the clusters (e.g., Small, Medium, Large, etc.)"
  type        = string
}

variable "min_num_clusters" {
  description = "Minimum number of clusters"
  type        = number
  default     = 1
}

variable "max_num_clusters" {
  description = "Maximum number of clusters"
  type        = number
  default     = 1
}

variable "auto_stop_mins" {
  description = "Duration in minutes before auto-stopping"
  type        = number
  default     = 120
}

variable "enable_photon" {
  description = "Enable Photon acceleration"
  type        = bool
  default     = true
}

variable "warehouse_type" {
  description = "Type of SQL warehouse (PRO, CLASSIC)"
  type        = string
  default     = "PRO"
}

variable "spot_instance_policy" {
  description = "Policy for spot instances (COST_OPTIMIZED, RELIABILITY_OPTIMIZED)"
  type        = string
  default     = "COST_OPTIMIZED"
}

variable "channel" {
  description = "Release channel name"
  type        = string
  default     = null
}