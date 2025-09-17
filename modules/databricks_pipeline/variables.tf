variable "name" {
  description = "Name of the pipeline"
  type        = string
}

variable "storage" {
  description = "Storage location for the pipeline"
  type        = string
}

variable "target" {
  description = "Target table for the pipeline"
  type        = string
}

variable "channel" {
  description = "Release channel for the pipeline"
  type        = string
  default     = "CURRENT"
}

variable "edition" {
  description = "Pipeline edition (ADVANCED, CORE)"
  type        = string
  default     = "ADVANCED"
}

variable "photon" {
  description = "Enable Photon execution"
  type        = bool
  default     = true
}

variable "cluster_config" {
  description = "Pipeline cluster configuration"
  type = object({
    label               = string
    num_workers         = number
    driver_node_type_id = string
    node_type_id        = string
    custom_tags         = optional(map(string))
  })
  default = null
}

variable "libraries" {
  description = "List of libraries to install on the pipeline cluster"
  type = list(object({
    maven_coordinates = string
  }))
  default = []
}

variable "notifications" {
  description = "Pipeline notifications configuration"
  type = object({
    email_recipients = list(string)
    on_failure      = bool
    on_success      = bool
  })
  default = null
}