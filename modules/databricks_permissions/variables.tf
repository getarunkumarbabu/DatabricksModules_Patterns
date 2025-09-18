variable "sql_endpoint_id" {
  description = "The ID of the SQL endpoint to set permissions on"
  type        = string
  default     = null
}

variable "cluster_id" {
  description = "The ID of the cluster to set permissions on"
  type        = string
  default     = null
}

variable "job_id" {
  description = "The ID of the job to set permissions on"
  type        = string
  default     = null
}

variable "notebook_path" {
  description = "The path of the notebook to set permissions on"
  type        = string
  default     = null
}

variable "pipeline_id" {
  description = "The ID of the pipeline to set permissions on"
  type        = string
  default     = null
}

variable "access_controls" {
  description = "List of access control configurations"
  type = list(object({
    group_name             = optional(string)
    service_principal_name = optional(string)
    user_name              = optional(string)
    permission_level       = string
  }))
  default = []

  validation {
    condition = alltrue([
      for ac in var.access_controls :
      contains(["CAN_USE", "CAN_MANAGE", "CAN_VIEW", "CAN_RUN", "IS_OWNER"], ac.permission_level)
    ])
    error_message = "Permission level must be one of: CAN_USE, CAN_MANAGE, CAN_VIEW, CAN_RUN, IS_OWNER."
  }
}