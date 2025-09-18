variable "name" {
  description = "Name of the SQL warehouse"
  type        = string

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 64
    error_message = "Warehouse name must be between 3 and 64 characters."
  }
}

variable "cluster_size" {
  description = "Size of the clusters. Valid values for Azure: 2X-Small, X-Small, Small, Medium, Large, X-Large, 2X-Large, 3X-Large, 4X-Large"
  type        = string

  validation {
    condition = contains([
      "2X-Small", "X-Small", "Small", "Medium", "Large",
      "X-Large", "2X-Large", "3X-Large", "4X-Large"
    ], var.cluster_size)
    error_message = "Invalid cluster size. Must be one of: 2X-Small, X-Small, Small, Medium, Large, X-Large, 2X-Large, 3X-Large, 4X-Large."
  }
}

variable "min_num_clusters" {
  description = "Minimum number of clusters. Must be between 1 and the max_num_clusters value."
  type        = number
  default     = 1

  validation {
    condition     = var.min_num_clusters >= 1
    error_message = "Minimum number of clusters must be at least 1."
  }
}

variable "max_num_clusters" {
  description = "Maximum number of clusters. Must be between min_num_clusters and 30."
  type        = number
  default     = 1

  validation {
    condition     = var.max_num_clusters >= 1 && var.max_num_clusters <= 30
    error_message = "Maximum number of clusters must be between 1 and 30."
  }
}

variable "auto_stop_mins" {
  description = "Duration in minutes of inactivity before automatically stopping the warehouse. Set to 0 to disable auto-stop."
  type        = number
  default     = 120

  validation {
    condition     = var.auto_stop_mins >= 0
    error_message = "Auto-stop minutes must be >= 0."
  }
}

variable "enable_photon" {
  description = "Enable Photon acceleration for better query performance"
  type        = bool
  default     = true
}

variable "warehouse_type" {
  description = "Type of SQL warehouse. PRO offers better performance and concurrency."
  type        = string
  default     = "PRO"

  validation {
    condition     = contains(["PRO", "CLASSIC"], var.warehouse_type)
    error_message = "Warehouse type must be either PRO or CLASSIC."
  }
}

variable "spot_instance_policy" {
  description = "Policy for spot instances. COST_OPTIMIZED may have lower cost but higher probability of preemption."
  type        = string
  default     = "COST_OPTIMIZED"

  validation {
    condition     = contains(["COST_OPTIMIZED", "RELIABILITY_OPTIMIZED"], var.spot_instance_policy)
    error_message = "Spot instance policy must be either COST_OPTIMIZED or RELIABILITY_OPTIMIZED."
  }
}

variable "channel" {
  description = "Release channel name. Use for accessing preview features."
  type        = string
  default     = null

  validation {
    condition     = var.channel == null || contains(["CHANNEL_NAME_CURRENT", "CHANNEL_NAME_PREVIEW"], var.channel)
    error_message = "Channel must be either CHANNEL_NAME_CURRENT or CHANNEL_NAME_PREVIEW."
  }
}