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
  description = "Release channel for the pipeline (CURRENT or PREVIEW)"
  type        = string
  default     = "CURRENT"

  validation {
    condition     = contains(["CURRENT", "PREVIEW"], var.channel)
    error_message = "Channel must be either CURRENT or PREVIEW."
  }
}

variable "edition" {
  description = "Pipeline edition (ADVANCED or CORE)"
  type        = string
  default     = "ADVANCED"

  validation {
    condition     = contains(["ADVANCED", "CORE"], var.edition)
    error_message = "Edition must be either ADVANCED or CORE."
  }
}

variable "photon" {
  description = "Enable Photon execution engine for better performance"
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

  validation {
    condition     = var.cluster_config == null || var.cluster_config.num_workers > 0
    error_message = "Number of workers must be greater than 0."
  }

  validation {
    condition     = var.cluster_config == null || can(regex("^Standard_[A-Za-z0-9]+_v[0-9]$", var.cluster_config.node_type_id))
    error_message = "Node type ID must be a valid Azure VM type (e.g., Standard_DS3_v2)."
  }

  validation {
    condition     = var.cluster_config == null || can(regex("^Standard_[A-Za-z0-9]+_v[0-9]$", var.cluster_config.driver_node_type_id))
    error_message = "Driver node type ID must be a valid Azure VM type (e.g., Standard_DS3_v2)."
  }
}

variable "libraries" {
  description = "List of libraries to install on the pipeline cluster"
  type = list(object({
    maven_coordinates = string
  }))
  default = []

  validation {
    condition     = alltrue([for lib in var.libraries : can(regex("^[a-zA-Z0-9.:-]+:[a-zA-Z0-9.-]+:[a-zA-Z0-9.-]+$", lib.maven_coordinates))])
    error_message = "Maven coordinates must be in the format 'groupId:artifactId:version'."
  }
}

variable "notifications" {
  description = "Pipeline notifications configuration"
  type = object({
    email_recipients = list(string)
    alerts_enabled  = bool
  })
  default = null

  validation {
    condition     = var.notifications == null || length(var.notifications.email_recipients) > 0
    error_message = "At least one email recipient must be specified when notifications are enabled."
  }

  validation {
    condition     = var.notifications == null || alltrue([for email in var.notifications.email_recipients : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))])
    error_message = "All email addresses must be in valid format."
  }
}