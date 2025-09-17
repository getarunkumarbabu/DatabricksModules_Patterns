variable "cluster_policy_id" {
  description = "ID of the cluster policy to set permissions on"
  type        = string
  default     = null
}

variable "instance_pool_id" {
  description = "ID of the instance pool to set permissions on"
  type        = string
  default     = null
}

variable "job_id" {
  description = "ID of the job to set permissions on"
  type        = string
  default     = null
}

variable "notebook_path" {
  description = "Path to the notebook to set permissions on"
  type        = string
  default     = null
}

variable "access_controls" {
  description = "List of access control rules"
  type = list(object({
    permission_level       = string
    user_name             = optional(string)
    group_name            = optional(string)
    service_principal_name = optional(string)
  }))
}