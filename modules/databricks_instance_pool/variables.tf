variable "name" {
  description = "Instance pool name"
  type        = string
}

variable "min_idle_instances" {
  description = "Minimum number of idle instances maintained in the pool"
  type        = number
  default     = 0
}

variable "max_capacity" {
  description = "Maximum number of instances the pool can contain, including both idle and in-use instances"
  type        = number
}

variable "node_type_id" {
  description = "The node type ID for the instances in the pool (e.g., Standard_DS3_v2, Standard_F4s_v2)"
  type        = string
}

variable "idle_instance_autotermination_minutes" {
  description = "How many minutes an idle instance should be kept before being terminated"
  type        = number
  default     = 60
}

variable "enable_elastic_disk" {
  description = "Whether to enable elastic disk optimization on instances in the pool"
  type        = bool
  default     = true
}

variable "preloaded_spark_versions" {
  description = "List of Spark versions to preload on instances in the pool"
  type        = list(string)
  default     = null
}

variable "custom_tags" {
  description = "Custom tags to apply to all instances in the pool"
  type        = map(string)
  default     = null
}



variable "azure_attributes" {
  description = "Azure-specific attributes for the instance pool"
  type = object({
    availability        = string  # SPOT_AZURE or ON_DEMAND_AZURE
    spot_bid_max_price = optional(number)
  })
  default = null

  validation {
    condition     = var.azure_attributes == null || contains(["SPOT_AZURE", "ON_DEMAND_AZURE"], var.azure_attributes.availability)
    error_message = "Azure availability must be either SPOT_AZURE or ON_DEMAND_AZURE."
  }
}

variable "disk_spec" {
  description = "Disk specification for the instances in the pool"
  type = object({
    disk_count = number
    disk_size  = number
  })
  default = null
}

variable "preloaded_docker_images" {
  description = "Docker images to preload on the instances in the pool"
  type = list(object({
    url = string
    basic_auth = optional(object({
      username = string
      password = string
    }))
  }))
  default = null
}
